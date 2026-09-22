import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

/// SPORTCORE Theme configurations — premium upgrade
class AppThemeFactory {
  ThemeData get lightTheme => _buildLightTheme();
  ThemeData get darkTheme => _buildDarkTheme();

  ThemeData _buildLightTheme() {
    final baseTheme = ThemeData(brightness: Brightness.light);
    return baseTheme.copyWith(
      primaryColor: AppColorTokens.primary,
      scaffoldBackgroundColor: AppColorTokens.background,
      textTheme: GoogleFonts.cairoTextTheme(baseTheme.textTheme),
      appBarTheme: AppBarTheme(
        toolbarHeight: 56,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColorTokens.background,
        foregroundColor: AppColorTokens.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        shadowColor: Colors.black12,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: AppColorTokens.textPrimary,
          size: 22,
        ),
        titleTextStyle: GoogleFonts.cairo(
          color: AppColorTokens.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColorTokens.primary,
        secondary: AppColorTokens.accent,
        onSecondary: AppColorTokens.background,
        surface: AppColorTokens.surface,
        onSurface: AppColorTokens.textPrimary,
        onSurfaceVariant: AppColorTokens.textSecondary,
        outline: AppColorTokens.surfaceStrong,
        surfaceContainerHighest: AppColorTokens.surfaceStrong,
        error: AppColorTokens.error,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColorTokens.background,
        shadowColor: Colors.black12,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardBorder),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorTokens.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(
            color: AppColorTokens.surfaceStrong,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(
            color: AppColorTokens.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(color: AppColorTokens.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(
            color: AppColorTokens.error,
            width: 1.5,
          ),
        ),
        hintStyle: GoogleFonts.cairo(
          color: AppColorTokens.textMuted,
          fontSize: 13,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColorTokens.background,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorTokens.accent,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 6,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorTokens.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorTokens.primary,
          side: const BorderSide(color: AppColorTokens.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColorTokens.accent,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColorTokens.surface,
        selectedColor: AppColorTokens.primary,
        disabledColor: AppColorTokens.surfaceStrong,
        labelStyle: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColorTokens.textPrimary,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.chipBorder),
        side: const BorderSide(color: AppColorTokens.surfaceStrong),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColorTokens.surfaceStrong,
        thickness: 1,
        space: 1,
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minVerticalPadding: 8,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    final baseTheme = ThemeData(brightness: Brightness.dark);
    return baseTheme.copyWith(
      primaryColor: AppColorTokens.darkTextPrimary,
      scaffoldBackgroundColor: AppColorTokens.darkBackground,
      textTheme: GoogleFonts.cairoTextTheme(baseTheme.textTheme),
      appBarTheme: AppBarTheme(
        toolbarHeight: 56,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColorTokens.darkBackground,
        foregroundColor: AppColorTokens.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: AppColorTokens.darkTextPrimary,
          size: 22,
        ),
        titleTextStyle: GoogleFonts.cairo(
          color: AppColorTokens.darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColorTokens.darkTextPrimary,
        onPrimary: AppColorTokens.darkBackground,
        secondary: AppColorTokens.accent,
        onSecondary: AppColorTokens.darkTextPrimary,
        surface: AppColorTokens.darkSurface,
        onSurfaceVariant: AppColorTokens.darkTextSecondary,
        outline: AppColorTokens.darkSurfaceStrong,
        surfaceContainerHighest: AppColorTokens.darkSurfaceStrong,
        error: AppColorTokens.error,
        onError: AppColorTokens.darkBackground,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColorTokens.darkSurface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardBorder),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorTokens.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(
            color: AppColorTokens.darkSurfaceStrong,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(
            color: AppColorTokens.darkTextPrimary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(color: AppColorTokens.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.smBorder,
          borderSide: const BorderSide(
            color: AppColorTokens.error,
            width: 1.5,
          ),
        ),
        hintStyle: GoogleFonts.cairo(
          color: AppColorTokens.darkTextMuted,
          fontSize: 13,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColorTokens.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorTokens.accent,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 6,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorTokens.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorTokens.darkTextPrimary,
          side: const BorderSide(
            color: AppColorTokens.darkSurfaceStrong,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColorTokens.accent,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColorTokens.darkSurface,
        selectedColor: AppColorTokens.darkTextPrimary,
        labelStyle: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColorTokens.darkTextPrimary,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.chipBorder),
        side: const BorderSide(color: AppColorTokens.darkSurfaceStrong),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColorTokens.darkSurfaceStrong,
        thickness: 1,
        space: 1,
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minVerticalPadding: 8,
      ),
    );
  }
}
