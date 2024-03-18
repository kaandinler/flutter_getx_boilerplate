//Created by https://github.com/kaandinler

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/core/translations/messages.dart';

import 'package:getx_boilerplate/app/routes/app_pages.dart';

void localLogWriter(String text, {bool isError = false}) {
  // INFO pass the message to your favourite logging package here please note that even if enableLog: false log messages will be pushed in this callback you get check the flag if you want through GetConfig.isLogEnable
}

void mainCommon() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: AppPages.routes.first,
      locale: const Locale('tr', 'TR'),
      debugShowCheckedModeBanner: false,
      // locale: Get.deviceLocale,
      translations: Messages(),

      routingCallback: (routing) {
        //INFO This is a callback that is called whenever the routing is changed.
        //INFO We can show ads, navigate to a new page, etc.
        //     if (routing.current == '/second') {
        //   openAds();
        // }
      },
      transitionDuration: Get.defaultTransitionDuration, //300
      // transitionDuration: const Duration(milliseconds: 500),
      defaultTransition: Transition.circularReveal,
      enableLog: true,
      // logWriterCallback: localLogWriter,
    ),
  );
}
