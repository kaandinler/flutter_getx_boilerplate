import 'package:get/get.dart';
import 'package:getx_boilerplate/app/utils/app_new_version_control.dart';

//Created by https://github.com/kaandinler

class MainController extends GetxController {
  //TODO: Implement MainController

  final activeTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.log('MainController onInit');
  }

  @override
  void onReady() {
    super.onReady();
    // Check version when context is ready
    AppNewVersionControl.checkAppVersion();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndex(int index) {
    activeTab.value = index;
  }
}
