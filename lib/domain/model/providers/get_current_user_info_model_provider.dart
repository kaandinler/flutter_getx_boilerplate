import 'package:get/get.dart';
import 'package:getx_boilerplate/app/config/app_config.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_secure_storage_service.dart';
import 'package:getx_boilerplate/domain/model/get_current_user_info_model_model.dart';

class GetCurrentUserInfoModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return GetCurrentUserInfoModel.fromJson(map);
      }
      if (map is List) {
        return map
            .map((item) => GetCurrentUserInfoModel.fromJson(item))
            .toList();
      }
    };

    // Base URL from AppConfig
    final config = Get.find<AppConfig>();
    httpClient.baseUrl = config.baseUrl;

    // Enforce HTTPS and attach Authorization token if available
    httpClient.addRequestModifier<void>((request) async {
      final uri = Uri.parse(request.url);
      if (config.forceHttps && uri.scheme.toLowerCase() != 'https') {
        throw Exception('Insecure scheme blocked: \'${uri.scheme}\' for \'${request.url}\'');
      }
      if (!Get.isRegistered<ISecureStorageService>()) return request;
      final storage = Get.find<ISecureStorageService>();
      final token = await storage.read(key: 'auth_token');
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  Future<GetCurrentUserInfoModel?> getGetCurrentUserInfoModel(int id) async {
    final response = await get('getcurrentuserinfomodel/$id');
    return response.body;
  }

  Future<Response<GetCurrentUserInfoModel>> postGetCurrentUserInfoModel(
          GetCurrentUserInfoModel getcurrentuserinfomodel) async =>
      await post('getcurrentuserinfomodel', getcurrentuserinfomodel);
  Future<Response> deleteGetCurrentUserInfoModel(int id) async =>
      await delete('getcurrentuserinfomodel/$id');
}
