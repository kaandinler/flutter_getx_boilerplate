//Created by https://github.com/kaandinler

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/core/localization/localization.dart';
import 'package:getx_boilerplate/app/flavor/environment_badge.dart';
import 'package:getx_boilerplate/app/theme/app_theme.dart';
import 'package:getx_boilerplate/app/theme/theme_service.dart';
import 'package:getx_boilerplate/app/routes/app_pages.dart';
import 'package:getx_boilerplate/app/shared/error/global_error_handler.dart';
import 'package:getx_boilerplate/app/shared/widgets/app_error_view.dart';
import 'package:getx_boilerplate/app/di/dependency_injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void localLogWriter(String text, {bool isError = false}) {
  // INFO: Centralized GetX log hook
  if (isError) {
    debugPrint('E/GetX: $text');
  } else {
    debugPrint('I/GetX: $text');
  }
}

Future<void> bootstrapApp({String? envFile}) async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Friendly error widget for build failures
      ErrorWidget.builder = (FlutterErrorDetails details) {
        final message = kReleaseMode
            ? 'Beklenmeyen bir hata oluştu.'
            : details.exceptionAsString();
        return AppErrorView(message: message);
      };

      // Load .env before DI (asset load needs binding)
      if (envFile != null && envFile.isNotEmpty) {
        await dotenv.load(fileName: envFile);
      }

      await BoilerplateDependencyInjection.init();

      // Load JSON-based translations from assets
      final translations = await AppTranslations.loadFromAssets();

      final errorHandler = Get.isRegistered<GlobalErrorHandler>()
          ? Get.find<GlobalErrorHandler>()
          : GlobalErrorHandler();

      FlutterError.onError = (FlutterErrorDetails details) {
        if (!kReleaseMode) {
          FlutterError.presentError(details);
        }
        errorHandler.recordFlutterError(details);
      };
      ui.PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        errorHandler.recordError(error, stack, fatal: true);
        return true;
      };

      runApp(
        Obx(() {
          final themeService = Get.find<ThemeService>();
          return GetMaterialApp(
            title: "Boilerplate Application",
            initialRoute: AppPages.SPLASH,
            getPages: AppPages.routes,
            unknownRoute: AppPages.routes.first,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeService.themeMode.value,
            locale: Get.deviceLocale,
            fallbackLocale: kFallbackLocale,
            supportedLocales: kSupportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            translations: translations,
            routingCallback: (routing) {
              // Optional routing hook
            },
            builder: (context, child) {
              return EnvironmentsBadge(child: child!);
            },
            transitionDuration: Get.defaultTransitionDuration,
            defaultTransition: Transition.circularReveal,
            enableLog: !kReleaseMode,
            logWriterCallback: localLogWriter,
          );
        }),
      );
    },
    (error, stack) async {
      final handler = Get.isRegistered<GlobalErrorHandler>()
          ? Get.find<GlobalErrorHandler>()
          : GlobalErrorHandler();
      handler.recordError(error, stack, fatal: true);
    },
  );
}

void mainCommon() async {
  // Load JSON-based translations from assets (for non-flavor entrypoints)
  final translations = await AppTranslations.loadFromAssets();
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
        Obx(() {
          final themeService = Get.find<ThemeService>();
          return GetMaterialApp(
            title: "Boilerplate Application",
            initialRoute: AppPages.SPLASH,
            getPages: AppPages.routes,
            unknownRoute: AppPages.routes.first,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeService.themeMode.value,
            locale: Get.deviceLocale,
            fallbackLocale: kFallbackLocale,
            supportedLocales: kSupportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            translations: translations,
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
          );
        }),
      );
    },
    (error, stack) {
      errorHandler.recordError(error, stack, fatal: true);
    },
  );
}
