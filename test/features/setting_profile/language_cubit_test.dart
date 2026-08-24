import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    DioHelper.init();
  });

  group('LanguageCubit Tests', () {
    test('initial state default is Arabic', () async {
      final cubit = LanguageCubit();
      expect(cubit.state.locale.languageCode, equals('ar'));
      await cubit.close();
    });

    test('changeLanguage updates locale in state', () async {
      final cubit = LanguageCubit();
      await cubit.changeLanguage(const Locale('en'));
      expect(cubit.state.locale.languageCode, equals('en'));
      await cubit.close();
    });
  });
}
