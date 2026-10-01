import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ThemeBloc Tests', () {
    test('initial state initializes with given ThemeMode', () {
      final bloc = ThemeBloc(ThemeMode.light);
      expect(bloc.state.themeMode, equals(ThemeMode.light));
      expect(bloc.state.isDarkMode, isFalse);
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits updated ThemeMode when ThemeEvent.modeChanged is added',
      build: () => ThemeBloc(ThemeMode.light),
      act: (bloc) => bloc.add(const ThemeEvent.modeChanged(ThemeMode.dark)),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.dark),
      ],
    );

    blocTest<ThemeBloc, ThemeState>(
      'toggles theme when ThemeEvent.toggled is added',
      build: () => ThemeBloc(ThemeMode.light),
      act: (bloc) => bloc.add(const ThemeEvent.toggled()),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.dark),
      ],
    );
  });
}
