import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/theme_event.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:mousa_store/features/setting_profile/presentation/bloc/theme_event.dart';
export 'package:mousa_store/features/setting_profile/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeMode initialMode)
      : super(ThemeState(themeMode: initialMode)) {
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<ThemeToggled>(_onThemeToggled);
  }

  static const String _themeKey = 'themeMode';

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    if (event.mode == state.themeMode) return;

    emit(state.copyWith(themeMode: event.mode));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, event.mode.toString());
    } on Object catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final newMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    add(ThemeEvent.modeChanged(newMode));
  }
}
