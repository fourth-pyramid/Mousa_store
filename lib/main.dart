import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/main/app_content.dart';
import 'package:mousa_store/core/main/app_initializer.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/service/deep_link_service.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';
import 'package:mousa_store/firebase_options.dart';
import 'package:mousa_store/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global navigator key for deep linking
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await InternetStateManagerInitializer.initialize();
  final prefs = await SharedPreferences.getInstance();
  final initializer = AppInitializer(prefs);
  final result = await initializer.initialize();

  // Initialize deep link service
  DeepLinkService.instance.initialize(navigatorKey);

  // Handle automatic session expiration and redirection
  DioHelper.onSessionExpired = () {
    unawaited(getIt<AuthService>().logout());
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/auth',
      (route) => false,
    );
  };

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<LanguageCubit>()),
        BlocProvider(create: (context) => getIt<PriceModeCubit>()),
      ],
      child: InternetStateManagerInitializer(
        options: InternetStateOptions(
          checkConnectionPeriodic: const Duration(seconds: 5),
          labels: InternetStateLabels(
            noInternetTitle: () => lookupAppLocalizations(
              getIt<LanguageCubit>().state.locale,
            ).no_internet_title,
            descriptionText: () => lookupAppLocalizations(
              getIt<LanguageCubit>().state.locale,
            ).no_internet_description,
            tryAgainText: () => lookupAppLocalizations(
              getIt<LanguageCubit>().state.locale,
            ).try_again_text,
          ),
        ),

        child: AppContent(
          navigatorKey: navigatorKey,
          initialTokenValid: result.tokenValid,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    ),
  );
}
