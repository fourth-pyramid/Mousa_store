import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/theme/app_theme.dart';
import 'package:mousa_store/core/widgets/internet_connection_wrapper.dart';
import 'package:mousa_store/features/auth/presentation/pages/auth_page.dart';
import 'package:mousa_store/features/notification/data/datasources/push_notification_service.dart';
import 'package:mousa_store/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mousa_store/features/product/presentation/pages/product_details_page.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/language_bloc.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/theme_bloc.dart';
import 'package:mousa_store/features/wholesale_or_retail/presentation/pages/purchase_type_page.dart';

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
  static final _lightTheme = AppThemeFactory().lightTheme;
  static final _darkTheme = AppThemeFactory().darkTheme;
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
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeState>(
    buildWhen: (previous, current) => previous.themeMode != current.themeMode,
    builder: (context, themeState) {
      return BlocBuilder<LanguageBloc, LanguageState>(
        buildWhen: (previous, current) => previous.locale != current.locale,
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
              final isDark = Theme.of(context).brightness == Brightness.dark;

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
                child: InternetConnectionWrapper(child: child!),
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
            theme: _lightTheme,
            darkTheme: _darkTheme,
            localizationsDelegates: widget.localizationsDelegates,
            supportedLocales: widget.supportedLocales,
            home: homeScreen,
            onGenerateRoute: _onGenerateRoute,
          );
        },
      );
    },
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
