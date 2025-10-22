import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// Supported locales and assets
const List<Locale> kSupportedLocales = [
  Locale('en', 'US'),
  Locale('tr', 'TR'),
  Locale('de', 'DE'),
];

const Locale kFallbackLocale = Locale('en', 'US');

// Map GetX locale keys to asset paths
const Map<String, String> kLocaleAssetMap = {
  'en_US': 'assets/locales/en-US.json',
  'tr_TR': 'assets/locales/tr-TR.json',
  'de_DE': 'assets/locales/de-DE.json',
};

class AppTranslations extends Translations {
  final Map<String, Map<String, String>> _keys;
  AppTranslations(this._keys);

  @override
  Map<String, Map<String, String>> get keys => _keys;

  static Future<AppTranslations> loadFromAssets({
    Map<String, String> assetsByLocale = kLocaleAssetMap,
  }) async {
    final result = <String, Map<String, String>>{};
    for (final entry in assetsByLocale.entries) {
      final localeKey = entry.key;
      final asset = entry.value;
      try {
        final raw = await rootBundle.loadString(asset);
        if (raw.trim().isEmpty) {
          result[localeKey] = <String, String>{};
          continue;
        }
        final decoded = json.decode(raw);
        final flat = _flatten(decoded);
        result[localeKey] = flat;
      } catch (_) {
        result[localeKey] = <String, String>{};
      }
    }
    return AppTranslations(result);
  }
}

// Flattens nested JSON objects to dot.notation map of strings
Map<String, String> _flatten(dynamic jsonValue, {String prefix = ''}) {
  final map = <String, String>{};
  if (jsonValue is Map) {
    jsonValue.forEach((key, value) {
      final newKey = prefix.isEmpty ? '$key' : '$prefix.$key';
      map.addAll(_flatten(value, prefix: newKey));
    });
  } else if (jsonValue is List) {
    for (var i = 0; i < jsonValue.length; i++) {
      final newKey = prefix.isEmpty ? '$i' : '$prefix.$i';
      map.addAll(_flatten(jsonValue[i], prefix: newKey));
    }
  } else if (jsonValue != null) {
    map[prefix] = jsonValue.toString();
  }
  return map;
}
