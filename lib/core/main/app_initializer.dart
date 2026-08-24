import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationResult {
  InitializationResult({
    required this.tokenValid,
    required this.themeMode,
    required this.locale,
  });
  final bool tokenValid;
  final ThemeMode themeMode;
  final Locale locale;
}

class AppInitializer {
  AppInitializer(this.prefs);

  final SharedPreferences prefs;

  Future<InitializationResult> initialize() async {
    await CacheHelper.init();
    await CacheHelper.setFirstOpenDone();
    DioHelper.init();
    final themeMode = getInitialThemeMode();
    final locale = getInitialLanguage();
    await setupDi(initialThemeMode: themeMode);

    final authService = getIt<AuthService>();

    final accessToken = CacheHelper.getToken();

    var tokenValid = false;

    if (accessToken != null) {
      DioHelper.setToken(accessToken);
      tokenValid = true;
    }

    // شغل الـ authService عشان يجيب الـ user data لو الـ token valid
    if (tokenValid) {
      unawaited(Future.microtask(authService.refresh));
    }

    return InitializationResult(
      tokenValid: tokenValid,
      themeMode: themeMode,
      locale: locale,
    );
  }

  ThemeMode getInitialThemeMode() {
    final themeText = prefs.getString('themeMode');
    if (themeText?.contains('dark') ?? false) {
      return ThemeMode.dark;
    } else if (themeText?.contains('light') ?? false) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  Locale getInitialLanguage() {
    final langCode = prefs.getString('appLanguage') ?? 'ar';
    DioHelper.setLanguage(langCode);
    return Locale(langCode);
  }
}
