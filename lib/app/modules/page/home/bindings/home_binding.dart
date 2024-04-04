import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<HomeController>(
    //   HomeController(),
    // );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
