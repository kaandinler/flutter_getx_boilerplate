import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/concrete/local_storage_service.dart';
import 'package:getx_boilerplate/app/shared/concrete/secure_storage_service.dart';

class HomeController extends GetxController with StateMixin {
  LocalStorageService localStorage = Get.find(tag: 'LocalStorageService');
  SecureStorageService secureStorage = Get.find(tag: 'SecureStorageService');

  @override
  Future<void> onReady() async {
    super.onReady();
    //change state from loading to success with using StateMixin
    Future.delayed(const Duration(milliseconds: 1500), () => change(null, status: RxStatus.success()));
  }

  void saveDataToLocalStorage() {
    String value = 'değer 2';
    localStorage.save('local_key', value);
    Get.log('Data: $value saved to local storage');
  }

  void saveDataToSecureStorage() {
    String value = 'değer';
    secureStorage.writeSecure('secure_key', value);
    Get.log('Data: $value saved to secure storage');
  }

  Future<String> readDataFromLocalStorage() async {
    String value = await localStorage.read('local_key');
    Get.log('Data: $value read from local storage');
    return value;
  }

  Future<String> readDataFromSecureStorage() async {
    String value = await secureStorage.readSecure(key: 'secure_key') ?? 'boş';
    Get.log('Data: $value read from secure storage');
    return value;
  }

  void changeThemeMode() {
    bool isDarkTheme = !localStorage.isDarkTheme;
    localStorage.isDarkTheme = isDarkTheme;
    Get.changeTheme(isDarkTheme ? ThemeData.dark() : ThemeData.light());
  }
}
