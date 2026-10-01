import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
sealed class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState({
    required ThemeMode themeMode,
  }) = _ThemeState;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}
