import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/language_event.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:mousa_store/features/setting_profile/presentation/bloc/language_event.dart';
export 'package:mousa_store/features/setting_profile/presentation/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(locale: Locale('ar'))) {
    on<LanguageLoaded>(_onLanguageLoaded);
    on<LanguageChanged>(_onLanguageChanged);

    add(const LanguageEvent.loaded());
  }

  static const _key = 'appLanguage';

  /// Returns the saved locale (e.g. for app initialization).
  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'ar';
    DioHelper.setLanguage(langCode);
    return Locale(langCode);
  }

  Future<void> _onLanguageLoaded(
    LanguageLoaded event,
    Emitter<LanguageState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_key) ?? 'ar';
    DioHelper.setLanguage(langCode);
    if (state.locale.languageCode != langCode) {
      emit(state.copyWith(locale: Locale(langCode)));
    }
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, event.locale.languageCode);
    DioHelper.setLanguage(event.locale.languageCode);

    if (CacheHelper.getToken() != null) {
      getIt<FavoriteBloc>().add(const FavoritesFetchRequested());
      getIt<CartBloc>().add(const CartFetchRequested());
    }

    emit(state.copyWith(locale: event.locale));
  }
}
