import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_secure_storage_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/secure_storage_service.dart';
import 'package:getx_boilerplate/app/shared/error/global_error_handler.dart';

class BoilerplateDependencyInjection {
  static Future<void> init() async {
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

    // Global error handler
    Get.put<GlobalErrorHandler>(
      GlobalErrorHandler(),
      permanent: true,
    );
  }
}
