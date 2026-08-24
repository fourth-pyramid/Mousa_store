import 'package:flutter/material.dart';

/// SPORTCORE neutral color palette and dark mode tokens (Internal token container)
abstract class AppColorTokens {
  // Light Mode Core Colors
  static const Color primary = Color(0xFF111111);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceStrong = Color(0xFFE9E9E9);

  // Light Mode Text Colors
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textMuted = Color(0xFF999999);

  // Accent & Status Colors
  static const Color accent = Color(0xFFE10600);
  static const Color success = Color(0xFF16803C);
  static const Color error = Color(0xFFD92D20);
  static const Color warning = Color(0xFFB54708);

  // Dark Mode Tokens
  static const Color darkBackground = Color(0xFF0B0B0B);
  static const Color darkSurface = Color(0xFF161616);
  static const Color darkSurfaceStrong = Color(0xFF222222);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextMuted = Color(0xFF777777);

  // Legacy internal tokens
  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color scaffoldColor = background;
  static const Color errorLight = error;
  static const Color errorDark = Color(0xFFFF9A8B);
  static const Color darkInactiveTrack = Color(0xFF4A5568);
  static const Color darkInputFill = darkSurface;
  static const Color lightInputFill = surface;
  static const Color lightInactiveTrack = Color(0xFFE2E8F0);
  static const Color lightCard = background;
  static const Color darkCard = darkSurface;
}
