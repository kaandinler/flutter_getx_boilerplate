import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor/store/mem_cache_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:getx_boilerplate/app/config/app_config.dart';
import 'package:getx_boilerplate/app/network/api_error.dart';
import 'package:getx_boilerplate/app/network/auth_service.dart';
import 'package:getx_boilerplate/app/network/connectivity_service.dart';

class AppApiClient extends GetxService {
  late final Dio dio;
  final AuthService authService;
  final ConnectivityService connectivity;

  AppApiClient({required this.authService, required this.connectivity});

  Future<AppApiClient> init() async {
    final config = Get.find<AppConfig>();
    final baseOptions = BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    dio = Dio(baseOptions);

    // Cache (in-memory by default)
    final cacheOptions = CacheOptions(
      store: MemCacheStore(maxSize: 10485760, maxEntrySize: 262144), // 10MB/256KB
      policy: CachePolicy.request, // use cache when valid, else network
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(hours: 1),
      priority: CachePriority.normal,
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    // Logging (debug only)
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ));
    }

    // Retry/backoff (network errors, 5xx)
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: kDebugMode ? print : null,
      retries: 3,
      retryDelays: const [
        Duration(milliseconds: 400),
        Duration(seconds: 1),
        Duration(seconds: 2),
      ],
      retryEvaluator: (error, attempt) {
        final status = error.response?.statusCode ?? 0;
        if (status >= 500) return true;
        return error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout;
      },
    ));

    // Auth + offline guard
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        await connectivity.ensureConnected();
        final token = await authService.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) async {
        if (e.error is NoConnectionException) {
          return handler.reject(e);
        }
        // Try token refresh on 401 once
        if (e.response?.statusCode == 401) {
          final newToken = await authService.refreshToken();
          if (newToken != null && newToken.isNotEmpty) {
            try {
              final opts = e.requestOptions;
              opts.headers[HttpHeaders.authorizationHeader] = 'Bearer $newToken';
              final cloneReq = await dio.fetch(opts);
              return handler.resolve(cloneReq);
            } catch (_) {}
          }
        }
        handler.next(e);
      },
    ));

    return this;
  }

  // Convenience wrappers
  Future<Response<T>> getJson<T>(String path, {Map<String, dynamic>? query}) async {
    try {
      return await dio.get<T>(path, queryParameters: query);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<Response<T>> postJson<T>(String path, {dynamic data}) async {
    try {
      return await dio.post<T>(path, data: data);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final status = e.response?.statusCode;
    final msg = e.message ?? 'Request failed';
    return ApiException(statusCode: status, message: msg);
  }
}
