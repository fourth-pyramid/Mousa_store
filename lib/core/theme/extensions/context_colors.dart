import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_colors.dart';

extension AppColorsContextExtension on BuildContext {
  /// Single accessor for all UI semantic colors. Resolves light/dark automatically.
  AppSemanticColors get colors {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? AppSemanticColors.dark : AppSemanticColors.light;
  }
}

/// Centralized semantic colors definition for light and dark themes.
class AppSemanticColors {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color surfaceStrong;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textTertiary;
  final Color border;
  final Color divider;
  final Color success;
  final Color warning;
  final Color error;
  final Color onError;
  final Color info;
  final Color pending;
  final Color disabled;
  final Color transparent;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color inputFill;
  final List<Color> headerGradient;

  const AppSemanticColors({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.surfaceStrong,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textTertiary,
    required this.border,
    required this.divider,
    required this.success,
    required this.warning,
    required this.error,
    required this.onError,
    required this.info,
    required this.pending,
    required this.disabled,
    required this.transparent,
    required this.onPrimary,
    required this.onSecondary,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.inputFill,
    required this.headerGradient,
  });

  static const light = AppSemanticColors(
    primary: AppColorTokens.primary,
    secondary: AppColorTokens.accent,
    accent: AppColorTokens.accent,
    background: AppColorTokens.background,
    surface: AppColorTokens.surface,
    surfaceStrong: AppColorTokens.surfaceStrong,
    card: AppColorTokens.surface,
    textPrimary: AppColorTokens.textPrimary,
    textSecondary: AppColorTokens.textSecondary,
    textMuted: AppColorTokens.textMuted,
    textTertiary: AppColorTokens.textMuted,
    border: AppColorTokens.surfaceStrong,
    divider: AppColorTokens.surfaceStrong,
    success: AppColorTokens.success,
    warning: AppColorTokens.warning,
    error: AppColorTokens.error,
    onError: Colors.white,
    info: Colors.blue,
    pending: Colors.orange,
    disabled: AppColorTokens.lightInactiveTrack,
    transparent: Colors.transparent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColorTokens.textPrimary,
    onSurfaceVariant: AppColorTokens.textSecondary,
    inputFill: AppColorTokens.surface,
    headerGradient: [Color(0xFF111111), Color(0xFF1F1F1F)],
  );

  static const dark = AppSemanticColors(
    primary: AppColorTokens.darkTextPrimary,
    secondary: AppColorTokens.accent,
    accent: AppColorTokens.accent,
    background: AppColorTokens.darkBackground,
    surface: AppColorTokens.darkSurface,
    surfaceStrong: AppColorTokens.darkSurfaceStrong,
    card: AppColorTokens.darkSurface,
    textPrimary: AppColorTokens.darkTextPrimary,
    textSecondary: AppColorTokens.darkTextSecondary,
    textMuted: AppColorTokens.darkTextMuted,
    textTertiary: AppColorTokens.darkTextMuted,
    border: AppColorTokens.darkSurfaceStrong,
    divider: AppColorTokens.darkSurfaceStrong,
    success: AppColorTokens.success,
    warning: AppColorTokens.warning,
    error: AppColorTokens.error,
    onError: Colors.white,
    info: Colors.blue,
    pending: Colors.orange,
    disabled: AppColorTokens.darkInactiveTrack,
    transparent: Colors.transparent,
    onPrimary: AppColorTokens.darkBackground,
    onSecondary: AppColorTokens.darkTextPrimary,
    onSurface: AppColorTokens.darkTextPrimary,
    onSurfaceVariant: AppColorTokens.darkTextSecondary,
    inputFill: AppColorTokens.darkSurface,
    headerGradient: [Color(0xFF090909), Color(0xFF141414)],
  );
}
