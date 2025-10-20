//Created by https://github.com/kaandinler

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/core/translations/messages.dart';
import 'package:getx_boilerplate/app/flavor/environment_badge.dart';
import 'package:getx_boilerplate/app/routes/app_pages.dart';
import 'package:getx_boilerplate/app/shared/error/global_error_handler.dart';
import 'package:getx_boilerplate/app/shared/widgets/app_error_view.dart';

void localLogWriter(String text, {bool isError = false}) {
  // INFO: Centralized GetX log hook
  if (isError) {
    debugPrint('E/GetX: $text');
  } else {
    debugPrint('I/GetX: $text');
  }
}

void mainCommon() async {
  // Acquire global error handler (from DI if available)
  final errorHandler = Get.isRegistered<GlobalErrorHandler>()
      ? Get.find<GlobalErrorHandler>()
      : GlobalErrorHandler();

  // Route framework errors to our handler
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!kReleaseMode) {
      FlutterError.presentError(details);
    }
    errorHandler.recordFlutterError(details);
  };

  // Catch uncaught async errors that escape FlutterError
  ui.PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorHandler.recordError(error, stack, fatal: true);
    return true; // handled
  };

  // Show a friendly widget when a build fails
  ErrorWidget.builder = (FlutterErrorDetails details) {
    final message = kReleaseMode
        ? 'Beklenmeyen bir hata oluştu.'
        : details.exceptionAsString();
    return AppErrorView(message: message);
  };

  // Run app inside a guarded zone for last‑resort catching
  runZonedGuarded(
    () {
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
    },
    (error, stack) {
      errorHandler.recordError(error, stack, fatal: true);
    },
  );
}
