import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/notification/service/push_notification_service.dart';

class AuthService extends ChangeNotifier {
  AuthService() {
    _initialize();
  }

  String? _token;
  User? _user;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  String? get token => _token;

  User? get user => _user;

  void _initialize() {
    _token = CacheHelper.getToken();
    _user = CacheHelper.getUser();
    _isLoggedIn = _token != null && _token!.isNotEmpty;
  }

  Future<void> login(String token, User user) async {
    _token = token;
    _user = user;
    _isLoggedIn = true;

    await CacheHelper.saveToken(token);
    await CacheHelper.saveUser(user);

    notifyListeners();
  }

  Future<void> updateToken(String newToken) async {
    _token = newToken;
    _isLoggedIn = true;

    await CacheHelper.saveToken(newToken);

    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    _user = user;

    await CacheHelper.saveUser(user);

    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    _isLoggedIn = false;

    await CacheHelper.clearAll();
    DioHelper.setToken('');

    // Best Practice: Update FCM token to use unauthenticated endpoint immediately after logout
    unawaited(PushNotificationService.updateTokenToServer());

    notifyListeners();
  }

  void refresh() {
    _initialize();
    notifyListeners();
  }
}
