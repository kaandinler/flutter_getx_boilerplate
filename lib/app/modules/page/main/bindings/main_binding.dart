import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import 'package:getx_boilerplate/app/modules/page/home/controllers/home_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    // Ensure HomeController is available when HomeView is used inside MainView's tabs.
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}
