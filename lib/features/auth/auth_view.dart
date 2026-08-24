import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:mousa_store/features/auth/widgets/auth_header.dart';
import 'package:mousa_store/features/auth/widgets/form/login_form.dart';
import 'package:mousa_store/features/auth/widgets/form/signup_form.dart';
import 'package:mousa_store/features/notification/service/push_notification_service.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, this.startWithLogin = true});
  final bool startWithLogin;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late final ValueNotifier<bool> _isLoginNotifier;

  @override
  void initState() {
    super.initState();
    _isLoginNotifier = ValueNotifier<bool>(widget.startWithLogin);

    // Best Practice: Sync FCM token when entering the login/signup view
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
                  BlocProvider(create: (context) => getIt<LoginCubit>()),
                  BlocProvider(create: (context) => getIt<SignupCubit>()),
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
