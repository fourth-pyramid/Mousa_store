import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/language_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    DioHelper.init();
  });

  group('LanguageBloc Tests', () {
    test('initial state default is Arabic', () {
      final bloc = LanguageBloc();
      expect(bloc.state.locale.languageCode, equals('ar'));
    });

    blocTest<LanguageBloc, LanguageState>(
      'emits updated locale when LanguageEvent.changed is added',
      build: LanguageBloc.new,
      act: (bloc) => bloc.add(const LanguageEvent.changed(Locale('en'))),
      expect: () => [
        const LanguageState(locale: Locale('en')),
      ],
    );
  });
}
