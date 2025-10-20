import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_secure_storage_service.dart';
import 'package:getx_boilerplate/app/theme/theme_service.dart';

class HomeController extends GetxController with StateMixin {
  final ILocalStorageService localStorage = Get.find<ILocalStorageService>();
  final ISecureStorageService secureStorage = Get.find<ISecureStorageService>();
  final ThemeService themeService = Get.find<ThemeService>();

  @override
  Future<void> onReady() async {
    super.onReady();
    // change state from loading to success with using StateMixin
    Future.delayed(
      const Duration(milliseconds: 1500),
      () => change(null, status: RxStatus.success()),
    );
  }

  void saveDataToLocalStorage() {
    const String value = 'değer 2';
    localStorage.save('local_key', value);
    Get.log('Data: $value saved to local storage');
  }

  void saveDataToSecureStorage() {
    const String value = 'değer';
    secureStorage.writeSecure('secure_key', value);
    Get.log('Data: $value saved to secure storage');
  }

  Future<String?> readDataFromLocalStorage() async {
    final value = await localStorage.read('local_key');
    Get.log('Data: $value read from local storage');
    return value;
  }

  Future<String> readDataFromSecureStorage() async {
    final value = await secureStorage.readSecure(key: 'secure_key') ?? 'boş';
    Get.log('Data: $value read from secure storage');
    return value;
  }

  void changeThemeMode() {
    themeService.toggleDarkLight();
  }
}
