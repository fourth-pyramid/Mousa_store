import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ThemeCubit Tests', () {
    test('initial state initializes with given ThemeMode', () async {
      final cubit = ThemeCubit(ThemeMode.light);
      expect(cubit.state.themeMode, equals(ThemeMode.light));
      expect(cubit.state.isDarkMode, isFalse);
      await cubit.close();
    });

    test('setThemeMode updates state properly', () async {
      final cubit = ThemeCubit(ThemeMode.light);
      await cubit.setThemeMode(ThemeMode.dark);
      expect(cubit.state.themeMode, equals(ThemeMode.dark));
      expect(cubit.state.isDarkMode, isTrue);
      await cubit.close();
    });

    test('toggleTheme switches between dark and light', () async {
      final cubit = ThemeCubit(ThemeMode.light);
      await cubit.toggleTheme();
      expect(cubit.state.themeMode, equals(ThemeMode.dark));
      await cubit.toggleTheme();
      expect(cubit.state.themeMode, equals(ThemeMode.light));
      await cubit.close();
    });
  });
}
