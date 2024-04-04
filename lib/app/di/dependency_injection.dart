import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/concrete/local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/secure_storage_service.dart';

class BoilerplateDependencyInjection {
  static Future<void> init() async {
    // Register dependencies here
    Get.put(LocalStorageService(), tag: 'LocalStorageService');
    Get.put(SecureStorageService(), tag: 'SecureStorageService');
  }
}
