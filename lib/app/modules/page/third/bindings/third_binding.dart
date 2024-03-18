import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/third/controllers/third_controller.dart';

class ThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThirdController>(
      () => ThirdController(),
    );
  }
}
