// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // In-memory cache for ultra-fast synchronous access
  static String? _cachedAccessToken;
  static String? _cachedRefreshToken;
  static int? _cachedRefreshTokenExpiry;
  static User? _cachedUser;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    // 1. Load tokens and user from secure storage
    try {
      _cachedAccessToken = await _secureStorage.read(key: 'access_token');
      _cachedRefreshToken = await _secureStorage.read(key: 'refresh_token');
      final expiryStr = await _secureStorage.read(key: 'refresh_token_expiry');
      if (expiryStr != null) {
        _cachedRefreshTokenExpiry = int.tryParse(expiryStr);
      }

      final userJsonStr = await _secureStorage.read(key: 'user_data');
      if (userJsonStr != null) {
        final userMap = jsonDecode(userJsonStr) as Map<String, dynamic>;
        _cachedUser = User.fromJson(userMap);
      }
    } on Object catch (e) {
      debugPrint('⚠️ Error reading secure storage: $e');
    }

    // 2. Migration: if old tokens/user exist in SharedPreferences, migrate to SecureStorage
    if (_cachedAccessToken == null && _prefs != null) {
      final oldToken = _prefs!.getString('access_token');
      if (oldToken != null && oldToken.isNotEmpty) {
        await saveToken(oldToken);
        await _prefs!.remove('access_token');
      }
    }

    if (_cachedRefreshToken == null && _prefs != null) {
      final oldRefreshToken = _prefs!.getString('refresh_token');
      final oldExpiry = _prefs!.getInt('refresh_token_expiry') ?? 0;
      if (oldRefreshToken != null && oldRefreshToken.isNotEmpty) {
        await saveRefreshTokenWithExpiry(oldRefreshToken, oldExpiry);
        await _prefs!.remove('refresh_token');
        await _prefs!.remove('refresh_token_expiry');
      }
    }

    if (_cachedUser == null && _prefs != null) {
      final oldUserStr = _prefs!.getString('user_data');
      if (oldUserStr != null && oldUserStr.isNotEmpty) {
        try {
          final userMap = jsonDecode(oldUserStr) as Map<String, dynamic>;
          final user = User.fromJson(userMap);
          await saveUser(user);
        } on Object catch (e) {
          debugPrint('⚠️ Error migrating user data to secure storage: $e');
        }
        await _prefs!.remove('user_data');
      }
    }
  }

  // ======== First Open ========

  static Future<bool> setFirstOpenDone() async {
    if (_prefs == null) return false;
    return _prefs!.setBool('is_first_open', false);
  }

  static bool isFirstOpen() {
    if (_prefs == null) return true;
    return _prefs!.getBool('is_first_open') ?? true;
  }

  // ======== Access Token (Secure Storage) ========

  static Future<bool> saveToken(String token) async {
    _cachedAccessToken = token;
    try {
      await _secureStorage.write(key: 'access_token', value: token);
      return true;
    } on Object catch (e) {
      debugPrint('Error saving token to secure storage: $e');
      return false;
    }
  }

  static String? getToken() => _cachedAccessToken;

  static Future<void> clearToken() async {
    _cachedAccessToken = null;
    try {
      await _secureStorage.delete(key: 'access_token');
    } on Object catch (e) {
      debugPrint('Error deleting token from secure storage: $e');
    }
  }

  // ======== Refresh Token (Secure Storage) ========

  static Future<bool> saveRefreshToken(
    String token, {
    int daysValid = 7,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final expiry = now + daysValid * 24 * 60 * 60 * 1000;
    return saveRefreshTokenWithExpiry(token, expiry);
  }

  static Future<bool> saveRefreshTokenWithExpiry(
    String token,
    int expiry,
  ) async {
    _cachedRefreshToken = token;
    _cachedRefreshTokenExpiry = expiry;
    try {
      await _secureStorage.write(key: 'refresh_token', value: token);
      await _secureStorage.write(
        key: 'refresh_token_expiry',
        value: expiry.toString(),
      );
      return true;
    } on Object catch (e) {
      debugPrint('Error saving refresh token: $e');
      return false;
    }
  }

  static String? getRefreshToken() {
    if (_cachedRefreshToken == null) return null;

    final expiry = _cachedRefreshTokenExpiry ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now > expiry) {
      unawaited(clearRefreshToken());
      return null;
    }

    return _cachedRefreshToken;
  }

  static Future<void> clearRefreshToken() async {
    _cachedRefreshToken = null;
    _cachedRefreshTokenExpiry = null;
    try {
      await _secureStorage.delete(key: 'refresh_token');
      await _secureStorage.delete(key: 'refresh_token_expiry');
    } on Object catch (e) {
      debugPrint('Error clearing refresh token: $e');
    }
  }

  static Future<void> clearAll() async {
    await clearToken();
    await clearRefreshToken();
    await clearUser();
    if (_prefs != null) {
      final isFirst = isFirstOpen();
      final priceMode = getPriceMode();
      await _prefs!.clear();
      // preserve first open status and price mode preference across logouts
      if (!isFirst) {
        await _prefs!.setBool('is_first_open', false);
      }
      if (priceMode != null) {
        await _prefs!.setString('price_mode', priceMode);
      }
    }
  }

  // ======== User Data (Secure Storage) ========

  static Future<bool> saveUser(User user) async {
    _cachedUser = user;
    try {
      final userJson = jsonEncode(user.toJson());
      await _secureStorage.write(key: 'user_data', value: userJson);
      return true;
    } on Object catch (e) {
      debugPrint('Error saving user to secure storage: $e');
      return false;
    }
  }

  static User? getUser() => _cachedUser;

  static Future<void> clearUser() async {
    _cachedUser = null;
    try {
      await _secureStorage.delete(key: 'user_data');
    } on Object catch (e) {
      debugPrint('Error deleting user from secure storage: $e');
    }
  }

  // ======== Price Mode ========

  static Future<bool> savePriceMode(String mode) async {
    if (_prefs == null) return false;
    return _prefs!.setString('price_mode', mode);
  }

  static String? getPriceMode() {
    if (_prefs == null) return null;
    return _prefs!.getString('price_mode');
  }
}
