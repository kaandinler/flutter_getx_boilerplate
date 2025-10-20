import 'package:flutter/material.dart';

class AppColors {
  // Brand seed color
  static const Color seed = Color(0xFF6750A4); // Deep purple

  // Neutrals
  static const Color neutral900 = Color(0xFF111111);
  static const Color neutral50 = Color(0xFFF7F7F7);

  // Semantic
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);

  static ColorScheme lightScheme() => ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      );

  static ColorScheme darkScheme() => ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.dark,
      );
}

