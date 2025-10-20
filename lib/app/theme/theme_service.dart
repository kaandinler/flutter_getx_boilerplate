import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_local_storage_service.dart';

class ThemeService extends GetxService {
  ThemeService(this._storage);

  final ILocalStorageService _storage;

  static const String keyV2 = 'theme_mode_v2'; // values: system|light|dark

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  Future<ThemeService> init() async {
    final stored = await _storage.read(keyV2) as String?;
    if (stored == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (stored == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else if (stored == 'system') {
      themeMode.value = ThemeMode.system;
    } else {
      // Backward-compat: fall back to boolean isDarkTheme
      final isDark = _storage.isDarkTheme;
      themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    }
    return this;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    await _storage.save(keyV2, _encode(mode));
    Get.changeThemeMode(mode);
  }

  Future<void> toggleDarkLight() async {
    final next = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(next);
  }

  String _encode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

