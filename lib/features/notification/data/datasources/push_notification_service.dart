import 'dart:async';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_colors.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ================= BACKGROUND HANDLER =================
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🔕 Background message: ${message.messageId}');
}

/// ================= SERVICE =================
class PushNotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // ponytail: dedup concurrent sendTokenToBackend calls with the same token
  static final Set<String> _inFlight = {};

  /// ============== INITIALIZE =================
  static Future<void> initialize() async {
    try {
      /// -------- Awesome Notifications --------
      await AwesomeNotifications()
          .initialize('resource://drawable/ic_notification', [
            NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic Notifications',
              channelDescription: 'Used for basic push notifications',
              importance: NotificationImportance.High,
              channelShowBadge: true,
              defaultColor: AppColorTokens.accent,
              ledColor: AppColorTokens.accent,
            ),
          ], debug: true);

      final isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }

      /// -------- Firebase Background --------
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      /// -------- Request Permission --------
      final settings = await _fcm.requestPermission();

      debugPrint('🔔 Notification permission: ${settings.authorizationStatus}');

      /// -------- Foreground Messages --------
      FirebaseMessaging.onMessage.listen((message) {
        debugPrint('🔔 Foreground message received');
        debugPrint('📦 Data: ${message.data}');

        if (message.notification != null) {
          unawaited(
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: Random().nextInt(2147483647),
                channelKey: 'basic_channel',
                icon: 'resource://drawable/ic_notification',
                color: AppColorTokens.accent,
                title: message.notification!.title,
                body: message.notification!.body,
                payload: message.data.map(
                  (key, value) => MapEntry(key, value.toString()),
                ),
              ),
            ),
          );
        }
      });

      /// -------- Open App From Notification --------
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        debugPrint('📲 App opened from notification');
        // handle navigation here
      });

      /// -------- Get Initial Token --------
      final token = await _fcm.getToken();
      debugPrint(' Initial FCM Token: $token');

      if (token != null) {
        await sendTokenToBackend(token);
      }

      /// -------- TOKEN REFRESH --------
      _fcm.onTokenRefresh.listen(
        (newToken) => unawaited(sendTokenToBackend(newToken)),
      );
    } on Object catch (e) {
      debugPrint('❌ Push Notification Init Error: $e');
    }
  }

  static Future<void> updateTokenToServer() async {
    try {
      final token = await _fcm.getToken();
      if (token != null) {
        await sendTokenToBackend(token);
      }
    } on Object catch (e) {
      debugPrint('❌ Update Token To Server Error: $e');
    }
  }

  static Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    var deviceId = prefs.getString('device_id');

    if (deviceId == null) {
      // ponytail: native random token without uuid dependency
      final rand = Random.secure();
      final values = List<int>.generate(16, (i) => rand.nextInt(256));
      deviceId = values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      await prefs.setString('device_id', deviceId);
    }

    return deviceId;
  }

  static Future<void> sendTokenToBackend(String token) async {
    // ponytail: skip if this exact token is already being sent
    if (!_inFlight.add(token)) return;
    try {
      final deviceId = await _getDeviceId();

      final authToken = CacheHelper.getToken();
      final endpoint = authToken != null ? 'fcm-token-user' : 'fcm-token';

      debugPrint(
        '🚀 Sending token to backend: $token with Device ID: $deviceId to endpoint: $endpoint',
      );

      final response = await DioHelper.postData(
        url: '$endpoint?fcm_token=$token&device_id=$deviceId',
        data: {},
      );

      if (response.statusCode == 200) {
        debugPrint('✅ Token sent successfully');
      } else {
        debugPrint('❌ Failed to send token: ${response.statusCode}');
      }
    } on Object catch (e) {
      debugPrint('🔴 Send token error: $e');
    } finally {
      _inFlight.remove(
        token,
      ); // allow re-send if token genuinely refreshed later
    }
  }
}
