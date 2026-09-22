import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State class
class ThemeState extends Equatable {
  const ThemeState({required this.themeMode});
  final ThemeMode themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  @override
  List<Object?> get props => [themeMode];
}

// Cubit class
class ThemeCubit extends SafeCubit<ThemeState> {
  ThemeCubit(ThemeMode initialMode) : super(ThemeState(themeMode: initialMode));

  static const String _themeKey = 'themeMode';

  Future<void> toggleTheme() async {
    final newThemeMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newThemeMode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (themeMode == state.themeMode) return;

    emit(ThemeState(themeMode: themeMode));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeMode.toString());
    } on Object catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }
}
