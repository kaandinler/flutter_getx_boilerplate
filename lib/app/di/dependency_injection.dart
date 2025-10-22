import 'package:get/get.dart';
import 'package:getx_boilerplate/app/config/app_config.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_secure_storage_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/secure_storage_service.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_bottom_sheet_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/bottom_sheet_service.dart';
import 'package:getx_boilerplate/app/shared/error/global_error_handler.dart';
import 'package:getx_boilerplate/app/theme/theme_service.dart';
import 'package:getx_boilerplate/app/security/security_service.dart';
import 'package:getx_boilerplate/app/network/connectivity_service.dart';
import 'package:getx_boilerplate/app/network/auth_service.dart';
import 'package:getx_boilerplate/app/network/api_client.dart';

class BoilerplateDependencyInjection {
  static Future<void> init() async {
    // App configuration loaded from .env (via flutter_dotenv)
    Get.put<AppConfig>(
      AppConfig.fromDotEnv(),
      permanent: true,
    );

    // Network security hardening (optional; reads flags from AppConfig)
    await Get.putAsync<SecurityService>(
      () async => SecurityService().init(),
      permanent: true,
    );

    // Connectivity service
    await Get.putAsync<ConnectivityService>(
      () async => ConnectivityService().init(),
      permanent: true,
    );

    // Core services
    await Get.putAsync<ILocalStorageService>(
      () async {
        final service = LocalStorageService();
        await service.init();
        return service;
      },
      permanent: true,
    );

    Get.put<ISecureStorageService>(
      SecureStorageService(),
      permanent: true,
    );

    // Auth + API client
    final secureStorage = Get.find<ISecureStorageService>();
    final authService = AuthService(secureStorage);
    Get.put<AuthService>(authService, permanent: true);
    await Get.putAsync<AppApiClient>(
      () async => AppApiClient(
        authService: Get.find<AuthService>(),
        connectivity: Get.find<ConnectivityService>(),
      ).init(),
      permanent: true,
    );

    // Global error handler
    Get.put<GlobalErrorHandler>(
      GlobalErrorHandler(),
      permanent: true,
    );

    // Theme service (depends on local storage)
    await Get.putAsync<ThemeService>(
      () async => ThemeService(Get.find<ILocalStorageService>()).init(),
      permanent: true,
    );

    // UI services
    Get.put<IBottomSheetService>(
      BottomSheetService(),
      permanent: true,
    );
  }
}
