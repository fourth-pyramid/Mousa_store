import 'dart:async';

import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/notification/data/datasources/push_notification_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  });

  Future<void> saveUser(User user);

  Future<void> onUserLoggedIn({
    required String token,
    required User user,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({required AuthService authService})
    : _authService = authService;

  final AuthService _authService;

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await CacheHelper.saveToken(accessToken);
    if (refreshToken != null) {
      await CacheHelper.saveRefreshToken(refreshToken);
    }
    DioHelper.setToken(accessToken);
  }

  @override
  Future<void> saveUser(User user) => CacheHelper.saveUser(user);

  @override
  Future<void> onUserLoggedIn({
    required String token,
    required User user,
  }) async {
    await _authService.login(token, user);
    unawaited(PushNotificationService.updateTokenToServer());
  }
}
