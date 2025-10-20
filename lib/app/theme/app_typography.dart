import 'package:flutter/material.dart';

class AppTypography {
  static TextTheme textThemeLight(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w400),
      displayMedium: base.displayMedium?.copyWith(fontWeight: FontWeight.w400),
      displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w400),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w500),
      headlineMedium: base.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge?.copyWith(height: 1.4),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.4),
      bodySmall: base.bodySmall?.copyWith(height: 1.4),
      labelLarge: base.labelLarge?.copyWith(letterSpacing: .3),
      labelMedium: base.labelMedium?.copyWith(letterSpacing: .3),
      labelSmall: base.labelSmall?.copyWith(letterSpacing: .3),
    );
  }

  static TextTheme textThemeDark(TextTheme base) {
    return textThemeLight(base);
  }
}

