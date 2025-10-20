import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  final String baseUrl;
  final Map<String, bool> featureFlags;
  final String logLevel;
  final bool forceHttps;
  final bool tlsPinningEnabled;
  final List<String> tlsPinAssetPaths;

  AppConfig({
    required this.baseUrl,
    required this.featureFlags,
    required this.logLevel,
    this.forceHttps = true,
    this.tlsPinningEnabled = false,
    this.tlsPinAssetPaths = const [],
  });

  static bool _parseBool(String? value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    switch (value.trim().toLowerCase()) {
      case '1':
      case 'true':
      case 'yes':
      case 'y':
        return true;
      case '0':
      case 'false':
      case 'no':
      case 'n':
        return false;
      default:
        return defaultValue;
    }
  }

  factory AppConfig.fromDotEnv() {
    final env = dotenv;

    final baseUrl = env.maybeGet('BASE_URL') ?? '';
    final logLevel = env.maybeGet('LOG_LEVEL') ?? 'info';
    final forceHttps = _parseBool(env.maybeGet('FORCE_HTTPS'), defaultValue: true);
    final tlsPinningEnabled = _parseBool(env.maybeGet('TLS_PINNING_ENABLED'), defaultValue: false);
    final tlsPinAssetsRaw = env.maybeGet('TLS_PIN_ASSETS') ?? '';
    final tlsPinAssets = tlsPinAssetsRaw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);

    final flags = <String, bool>{};
    // As of flutter_dotenv 5.x, entries are available via `env`.
    for (final e in env.env.entries) {
      final key = e.key;
      final val = e.value;
      if (key.startsWith('FEATURE_')) {
        final normalized = key.substring('FEATURE_'.length).toUpperCase();
        flags[normalized] = _parseBool(val);
      }
    }

    return AppConfig(
      baseUrl: baseUrl,
      featureFlags: flags,
      logLevel: logLevel,
      forceHttps: forceHttps,
      tlsPinningEnabled: tlsPinningEnabled,
      tlsPinAssetPaths: tlsPinAssets,
    );
  }

  bool isFeatureEnabled(String name, {bool defaultValue = false}) {
    return featureFlags[name.toUpperCase()] ?? defaultValue;
  }
}
