import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mousa_store/core/design_system/app_colors.dart';

/// SPORTCORE Typography Scale (Cairo font for unified AR / EN support)
abstract class AppTypography {
  static TextStyle _font({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color color = AppColorTokens.textPrimary,
  }) {
    final spSize = fontSize.sp;
    final baseStyle = TextStyle(
      fontSize: spSize,
      fontWeight: fontWeight,
      height: height / fontSize,
      color: color,
    );

    return GoogleFonts.cairo(textStyle: baseStyle);
  }

  // Scale Definitions (fontSize / lineHeight) - balanced for mobile e-commerce UI
  static TextStyle display({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 28,
    color: color,
  );

  static TextStyle h1({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 26,
    color: color,
  );

  static TextStyle h2({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    height: 22,
    color: color,
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
      );

  static TextStyle body({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    height: 18,
    color: color,
  );

  static TextStyle bodySmall({Color color = AppColorTokens.textSecondary}) =>
      _font(
        fontSize: 11.5,
        fontWeight: FontWeight.normal,
        height: 16,
        color: color,
      );

  static TextStyle label({Color color = AppColorTokens.textPrimary}) => _font(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 15,
    color: color,
  );

  static TextStyle caption({Color color = AppColorTokens.textMuted}) => _font(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 14,
    color: color,
  );

  static TextStyle button({Color color = AppColorTokens.background}) => _font(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 17,
    color: color,
  );
}
