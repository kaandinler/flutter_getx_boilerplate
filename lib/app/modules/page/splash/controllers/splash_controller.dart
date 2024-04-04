import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/home');
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
