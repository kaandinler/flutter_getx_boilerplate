import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/unknown/controllers/unknown_controller.dart';

class UnknownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnknownController>(
      () => UnknownController(),
    );
  }
}
