import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/theme/app_theme.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';
import 'package:mousa_store/features/auth/auth_view.dart';
import 'package:mousa_store/features/notification/service/push_notification_service.dart';
import 'package:mousa_store/features/onboarding/on_boarding_view.dart';
import 'package:mousa_store/features/product/view/product_details_view.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';
import 'package:mousa_store/features/wholesale_or_retail/purchase_type_view.dart';

class AppContent extends StatefulWidget {
  const AppContent({
    required this.navigatorKey,
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.initialTokenValid,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final bool initialTokenValid;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    unawaited(PushNotificationService.initialize());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(
      precacheImage(const AssetImage('assets/images/mousa_store.png'), context),
    );
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, _) => BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final themeFactory = AppThemeFactory();
        final lightTheme = themeFactory.lightTheme;
        final darkTheme = themeFactory.darkTheme;

        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, languageState) {
            final isFirst = CacheHelper.isFirstOpen();

            final Widget homeScreen = isFirst
                ? const OnboardingView()
                : (widget.initialTokenValid
                      ? const PurchaseTypeView()
                      : const AuthView());

            return MaterialApp(
              navigatorKey: widget.navigatorKey,
              locale: languageState.locale,
              builder: (context, child) {
                final mediaQuery = MediaQuery.of(context);
                final isDark = Theme.of(context).brightness == Brightness.dark;
                final clampedTextScaler = mediaQuery.textScaler.clamp(
                  minScaleFactor: 0.85,
                  maxScaleFactor: 1.35,
                );

                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: isDark
                        ? Brightness.light
                        : Brightness.dark,
                    statusBarBrightness: isDark
                        ? Brightness.dark
                        : Brightness.light,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    systemNavigationBarIconBrightness: isDark
                        ? Brightness.light
                        : Brightness.dark,
                    systemNavigationBarContrastEnforced: false,
                    systemStatusBarContrastEnforced: false,
                  ),
                  child: MediaQuery(
                    data: mediaQuery.copyWith(textScaler: clampedTextScaler),
                    child: child!,
                  ),
                );
              },
              themeAnimationStyle: const AnimationStyle(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 500),
                reverseCurve: Curves.easeOut,
                reverseDuration: Duration(milliseconds: 500),
              ),
              debugShowCheckedModeBanner: false,
              themeMode: themeState.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              localizationsDelegates: widget.localizationsDelegates,
              supportedLocales: widget.supportedLocales,
              home: homeScreen,
              onGenerateRoute: _onGenerateRoute,
            );
          },
        );
      },
    ),
  );

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/product') {
      final productId = settings.arguments as int?;
      if (productId != null) {
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(productId: productId),
        );
      }
    } else if (settings.name == '/auth') {
      return MaterialPageRoute(builder: (_) => const AuthView());
    }
    return null;
  }
}
