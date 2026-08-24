import 'dart:async';

import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/features/auth/model/login_response.dart';
import 'package:mousa_store/features/auth/service/login_service.dart';
import 'package:mousa_store/features/notification/service/push_notification_service.dart';

class LoginRepo {
  LoginRepo({required this.loginService});
  final LoginService loginService;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await loginService.login(email: email, password: password);

    if (response.success &&
        response.token != null &&
        response.refreshToken != null) {
      await loginService.saveTokens(
        accessToken: response.token!,
        refreshToken: response.refreshToken,
      );
      if (response.user != null) {
        await CacheHelper.saveUser(response.user!);

        // Update AuthService with new login state
        final authService = getIt<AuthService>();
        await authService.login(response.token!, response.user!);

        // Send FCM token to backend
        unawaited(PushNotificationService.updateTokenToServer());
      }
    }

    return response;
  }
}
