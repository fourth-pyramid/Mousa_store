import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_colors.dart';

/// SPORTCORE Typography Scale (Cairo font for unified AR / EN support)
abstract class AppTypography {
  /// Bundled font family declared in pubspec.yaml (assets/fonts/).
  static const String fontFamily = 'Cairo';

  static TextStyle _font({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color color = AppColorTokens.textPrimary,
    double letterSpacing = -0.2,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height / fontSize,
    color: color,
    letterSpacing: letterSpacing,
  );

  // Scale Definitions (fontSize / lineHeight) - balanced for mobile e-commerce UI
  static TextStyle display({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    height: 28,
    color: color,
    letterSpacing: -0.5,
  );

  static TextStyle h1({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 26,
    color: color,
    letterSpacing: -0.4,
  );

  static TextStyle h2({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 22,
    color: color,
    letterSpacing: -0.3,
  );

  static TextStyle h3({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 20,
    color: color,
  );

  static TextStyle bodyLarge({Color color = AppColorTokens.textPrimary}) =>
      _font(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 19,
        color: color,
        letterSpacing: -0.1,
      );

  static TextStyle body({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    height: 18,
    color: color,
    letterSpacing: -0.1,
  );

  static TextStyle bodySmall({Color color = AppColorTokens.textSecondary}) =>
      _font(
        fontSize: 11.5,
        fontWeight: FontWeight.normal,
        height: 16,
        color: color,
        letterSpacing: 0,
      );

  static TextStyle label({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 15,
    color: color,
    letterSpacing: 0,
  );

  static TextStyle caption({Color color = AppColorTokens.textMuted}) => _font(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 14,
    color: color,
    letterSpacing: 0,
  );

  static TextStyle button({Color color = AppColorTokens.background}) => _font(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 17,
    color: color,
    letterSpacing: 0,
  );

  static TextStyle price({Color color = AppColorTokens.primary}) => _font(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    height: 20,
    color: color,
    letterSpacing: -0.3,
  );

  static TextStyle overline({Color color = AppColorTokens.textMuted}) => _font(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    height: 12,
    color: color,
    letterSpacing: 0.5,
  );
}
