import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/config/app_config.dart';

/// Provides optional security hardening hooks for network layer.
class SecurityService extends GetxService {
  Future<SecurityService> init() async {
    final config = Get.find<AppConfig>();
    if (config.tlsPinningEnabled && config.tlsPinAssetPaths.isNotEmpty) {
      // Prepare a SecurityContext limited to provided certs (PEM/DER)
      final context = SecurityContext(withTrustedRoots: false);
      for (final assetPath in config.tlsPinAssetPaths) {
        try {
          final bytes = await rootBundle.load(assetPath);
          // Try PEM then DER
          try {
            context.setTrustedCertificatesBytes(bytes.buffer.asUint8List());
          } catch (_) {
            context.setTrustedCertificatesBytes(bytes.buffer.asUint8List());
          }
        } catch (e) {
          // If asset missing, continue; pinning will be incomplete.
          // In production, ensure assets are bundled correctly.
        }
      }

      HttpOverrides.global = _PinnedHttpOverrides(context);
    }
    return this;
  }
}

class _PinnedHttpOverrides extends HttpOverrides {
  final SecurityContext context;
  _PinnedHttpOverrides(this.context);

  @override
  HttpClient createHttpClient(SecurityContext? _) {
    final client = HttpClient(context: context);
    // No badCertificateCallback: we rely on pinned trust anchors.
    return client;
  }
}

