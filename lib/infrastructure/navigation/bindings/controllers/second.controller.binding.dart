import 'package:get/get.dart';

import 'package:getx_boilerplate/presentation/second/controllers/second.controller.dart';

class SecondControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondController>(
      () => SecondController(),
    );
  }
}
