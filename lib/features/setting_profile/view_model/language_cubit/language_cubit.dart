import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageState extends Equatable {
  const LanguageState(this.locale);
  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

class LanguageCubit extends SafeCubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('ar'))) {
    unawaited(_loadLocale());
  }

  static const _key = 'appLanguage';

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'ar';
    DioHelper.setLanguage(langCode);
    emit(LanguageState(Locale(langCode)));
  }

  /// تحميل اللغة المخزنة (Static method kept if needed elsewhere, but internal logic is now in constructor)
  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'ar';
    DioHelper.setLanguage(langCode);
    return Locale(langCode);
  }

  /// تغيير اللغة وتخزينها
  Future<void> changeLanguage(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newLocale.languageCode);
    DioHelper.setLanguage(newLocale.languageCode);

    // ponytail: skip auth-required endpoints when user is not logged in
    if (CacheHelper.getToken() != null) {
      unawaited(getIt<FavoriteCubit>().getFavorites());
      unawaited(getIt<CartCubit>().getCart());
    }

    emit(LanguageState(newLocale));
  }
}
