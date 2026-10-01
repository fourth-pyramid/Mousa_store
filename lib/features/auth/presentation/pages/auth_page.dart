import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/features/auth/presentation/bloc/login_bloc.dart';
import 'package:mousa_store/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:mousa_store/features/auth/presentation/widgets/auth_header.dart';
import 'package:mousa_store/features/auth/presentation/widgets/login_form.dart';
import 'package:mousa_store/features/auth/presentation/widgets/signup_form.dart';
import 'package:mousa_store/features/notification/data/datasources/push_notification_service.dart';

typedef AuthView = AuthPage;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, this.startWithLogin = true});
  final bool startWithLogin;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final ValueNotifier<bool> _isLoginNotifier;

  @override
  void initState() {
    super.initState();
    _isLoginNotifier = ValueNotifier<bool>(widget.startWithLogin);

    // Sync FCM token when entering the login/signup view
    unawaited(PushNotificationService.updateTokenToServer());
  }

  @override
  void dispose() {
    _isLoginNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    child: Scaffold(
      body: InternetStateManager(
        onRestoreInternetConnection: () {},
        child: ValueListenableBuilder<bool>(
          valueListenable: _isLoginNotifier,
          builder: (context, isLogin, _) => Column(
            children: [
              AuthHeader(
                isLogin: isLogin,
                onTabChanged: ({required isLogin}) {
                  _isLoginNotifier.value = isLogin;
                },
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<LoginBloc>()),
                  BlocProvider(create: (context) => getIt<SignupBloc>()),
                ],
                child: Expanded(
                  child: isLogin ? const LoginForm() : const SignupForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
