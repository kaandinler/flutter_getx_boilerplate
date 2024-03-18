import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/home/bindings/home_binding.dart';
import 'package:getx_boilerplate/app/modules/page/home/views/home_view.dart';
import 'package:getx_boilerplate/app/modules/page/main/bindings/main_binding.dart';
import 'package:getx_boilerplate/app/modules/page/main/views/main_view.dart';
import 'package:getx_boilerplate/app/modules/page/third/bindings/third_binding.dart';
import 'package:getx_boilerplate/app/modules/page/third/views/third_view.dart';
import 'package:getx_boilerplate/app/modules/page/unknown/bindings/unknown_binding.dart';
import 'package:getx_boilerplate/app/modules/page/unknown/views/unknown_view.dart';

//Created by https://github.com/kaandinler

part 'app_routes.dart';

// ignore_for_file: constant_identifier_names
class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const UNKNOWN = Routes.UNKNOWN;

  static final routes = [
    GetPage(
      name: _Paths.UNKNOWN,
      page: () => const UnknownView(),
      binding: UnknownBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      // middlewares: const [
      //   AuthMiddleware(),
      // ],
    ),
    GetPage(
      name: _Paths.THIRD,
      page: () => const ThirdView(),
      binding: ThirdBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
  ];
}
