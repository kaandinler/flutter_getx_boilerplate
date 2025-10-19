//Created by https://github.com/kaandinler

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/core/translations/messages.dart';
import 'package:getx_boilerplate/app/flavor/environment_badge.dart';
import 'package:getx_boilerplate/app/routes/app_pages.dart';

void localLogWriter(String text, {bool isError = false}) {
  // INFO: Centralized GetX log hook
  if (isError) {
    debugPrint('E/GetX: $text');
  } else {
    debugPrint('I/GetX: $text');
  }
}

void mainCommon() async {
  runApp(
    GetMaterialApp(
      title: "Boilerplate Application",
      initialRoute: AppPages.SPLASH,
      getPages: AppPages.routes,
      unknownRoute: AppPages.routes.first,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      locale: Get.deviceLocale,
      translations: Messages(),
      routingCallback: (routing) {
        //INFO This is a callback that is called whenever the routing is changed.
        //INFO We can show ads, navigate to a new page, etc.
        //     if (routing.current == '/second') {
        //   openAds();
        // }
      },
      builder: (context, child) {
        return EnvironmentsBadge(child: child!);
      },
      transitionDuration: Get.defaultTransitionDuration, //300
      // transitionDuration: const Duration(milliseconds: 500),
      defaultTransition: Transition.circularReveal,
      enableLog: !kReleaseMode,
      logWriterCallback: localLogWriter,
    ),
  );
}
