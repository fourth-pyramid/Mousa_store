import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_colors.dart';
import 'package:mousa_store/core/design_system/app_typography.dart';

extension AppTypographyContextExtension on BuildContext {
  /// Single accessor for all UI typography styles. Resolves light/dark default colors automatically.
  AppSemanticTypography get typography {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? AppSemanticTypography.dark : AppSemanticTypography.light;
  }
}

/// Centralized typography accessor providing dynamic theme-aware text styles.
class AppSemanticTypography {
  final TextStyle display;
  final TextStyle displayLarge;
  final TextStyle h1;
  final TextStyle headlineLarge;
  final TextStyle h2;
  final TextStyle titleLarge;
  final TextStyle h3;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle body;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle label;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle caption;
  final TextStyle button;

  const AppSemanticTypography._({
    required this.display,
    required this.displayLarge,
    required this.h1,
    required this.headlineLarge,
    required this.h2,
    required this.titleLarge,
    required this.h3,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.body,
    required this.bodyMedium,
    required this.bodySmall,
    required this.label,
    required this.labelLarge,
    required this.labelMedium,
    required this.caption,
    required this.button,
  });

  static AppSemanticTypography get light {
    const textSecondary = AppColorTokens.textSecondary;

    return AppSemanticTypography._(
      display: AppTypography.display(),
      displayLarge: AppTypography.display(),
      h1: AppTypography.h1(),
      headlineLarge: AppTypography.h1(),
      h2: AppTypography.h2(),
      titleLarge: AppTypography.h2(),
      h3: AppTypography.h3(),
      titleMedium: AppTypography.h3(),
      titleSmall: AppTypography.bodyLarge(),
      bodyLarge: AppTypography.bodyLarge(),
      body: AppTypography.body(),
      bodyMedium: AppTypography.body(),
      bodySmall: AppTypography.bodySmall(),
      label: AppTypography.label(),
      labelLarge: AppTypography.label(),
      labelMedium: AppTypography.label(color: textSecondary),
      caption: AppTypography.caption(),
      button: AppTypography.button(),
    );
  }

  static AppSemanticTypography get dark {
    const darkTextPrimary = AppColorTokens.darkTextPrimary;
    const darkTextSecondary = AppColorTokens.darkTextSecondary;
    const darkTextMuted = AppColorTokens.darkTextMuted;

    return AppSemanticTypography._(
      display: AppTypography.display(color: darkTextPrimary),
      displayLarge: AppTypography.display(color: darkTextPrimary),
      h1: AppTypography.h1(color: darkTextPrimary),
      headlineLarge: AppTypography.h1(color: darkTextPrimary),
      h2: AppTypography.h2(color: darkTextPrimary),
      titleLarge: AppTypography.h2(color: darkTextPrimary),
      h3: AppTypography.h3(color: darkTextPrimary),
      titleMedium: AppTypography.h3(color: darkTextPrimary),
      titleSmall: AppTypography.bodyLarge(color: darkTextPrimary),
      bodyLarge: AppTypography.bodyLarge(color: darkTextPrimary),
      body: AppTypography.body(color: darkTextPrimary),
      bodyMedium: AppTypography.body(color: darkTextPrimary),
      bodySmall: AppTypography.bodySmall(color: darkTextSecondary),
      label: AppTypography.label(color: darkTextPrimary),
      labelLarge: AppTypography.label(color: darkTextPrimary),
      labelMedium: AppTypography.label(color: darkTextSecondary),
      caption: AppTypography.caption(color: darkTextMuted),
      button: AppTypography.button(),
    );
  }
}
