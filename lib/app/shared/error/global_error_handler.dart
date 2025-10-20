import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/domain/core/failure.dart';

/// Centralized error reporting/handling for the app.
class GlobalErrorHandler {
  void recordFlutterError(FlutterErrorDetails details) {
    // Log
    Get.log('FlutterError: ${details.exceptionAsString()}');
    if (details.stack != null) {
      debugPrintStack(stackTrace: details.stack);
    }

    // Optionally show a non-blocking UI hint in debug/profile
    if (!kReleaseMode) {
      _showSnack(details.exceptionAsString());
    }
  }

  void recordError(Object error, StackTrace stack, {bool fatal = false}) {
    // Log
    Get.log('Uncaught: $error');
    debugPrintStack(stackTrace: stack);

    // Optionally surface a simple UI hint in debug/profile
    if (!kReleaseMode) {
      _showSnack(error.toString());
    }
  }

  /// Convert any error/exception to a typed Failure
  Failure toFailure(Object error, [StackTrace? stack]) {
    if (error is Failure) return error;
    final message = error.toString();
    return UnknownFailure(message: message);
  }

  void _showSnack(String message) {
    if (Get.isSnackbarOpen == true) return;
    Get.showSnackbar(
      GetSnackBar(
        title: 'Hata',
        message: message,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }
}

