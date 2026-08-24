// ignore_for_file: avoid_classes_with_only_static_members, avoid_dynamic_calls

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;
  static VoidCallback? onSessionExpired;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://bynona.store/api/v1/',
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(DuplicateRequestInterceptor());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final priceMode = CacheHelper.getPriceMode();
          if (priceMode != null) {
            options.headers['Price-Mode'] = priceMode;
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 &&
              !e.requestOptions.path.contains('refresh')) {
            debugPrint('🔄 401 Unauthorized: Attempting to refresh token...');

            final isRefreshed = await refreshAccessToken();

            if (isRefreshed) {
              final newToken = CacheHelper.getToken();
              if (newToken != null) {
                debugPrint('✅ Token refreshed successfully. Retrying request');

                e.requestOptions.headers['Authorization'] = 'Bearer $newToken';

                try {
                  final response = await dio.fetch<dynamic>(e.requestOptions);
                  return handler.resolve(response);
                } on DioException catch (retryError) {
                  return handler.next(retryError);
                }
              }
            } else {
              debugPrint('❌ Failed to refresh token. Triggering session expiration');
              onSessionExpired?.call();
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  static Future<bool> refreshAccessToken() async {
    final refreshToken = CacheHelper.getRefreshToken();
    if (refreshToken == null) {
      debugPrint('Refresh token expired or missing. User must login again.');
      return false;
    }

    try {
      final response = await dio.post<dynamic>(
        'refresh',
        data: {'refresh_token': refreshToken},
      );

      final data = response.data as Map<String, dynamic>? ?? {};

      if (data['status']?.toString().toLowerCase() == 'success') {
        final newAccessToken = data['token']?.toString();
        final newRefreshToken = data['refresh_token']?.toString();

        if (newAccessToken != null && newRefreshToken != null) {
          setToken(newAccessToken);
          await CacheHelper.saveToken(newAccessToken);
          await CacheHelper.saveRefreshToken(newRefreshToken);
          debugPrint('✅ Token refreshed and saved successfully');
          return true;
        }
      }

      debugPrint('❌ Refresh token response invalid');
      return false;
    } on Object catch (e) {
      debugPrint('❌ Error refreshing token: $e');
      return false;
    }
  }

  static void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void setLanguage(String language) {
    dio.options.headers['Accept-Language'] = language;
  }

  static void setPriceMode(String priceMode) {
    dio.options.headers['Price-Mode'] = priceMode;
  }

  static Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? language,
    String? priceMode,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept-Language': ?language,
            'Price-Mode': ?priceMode,
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response<dynamic>> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
    String? language,
    String? priceMode,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept-Language': ?language,
            'Price-Mode': ?priceMode,
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response<dynamic>> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
    String? language,
    String? priceMode,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.put(
        url,
        data: data,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept-Language': ?language,
            'Price-Mode': ?priceMode,
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response<dynamic>> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
    String? language,
    String? priceMode,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.delete(
        url,
        data: data,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept-Language': ?language,
            'Price-Mode': ?priceMode,
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static CustomDioError _handleError(DioException e) {
    // Cancelled requests are intentional — not real errors
    if (e.type == DioExceptionType.cancel) {
      return CustomDioError(
        message: 'Request cancelled',
        originalException: e,
      );
    }

    var errorMessage = 'حدث خطأ، حاول مرة أخرى';

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      errorMessage = 'No Internet Connection';
    } else if (e.type == DioExceptionType.unknown &&
        e.message != null &&
        e.message!.contains('SocketException')) {
      errorMessage = 'No Internet Connection';
    }

    if (e.response != null && e.response?.data is Map) {
      final data = e.response!.data;

      if (data['message'] != null) {
        errorMessage = data['message'].toString();
      } else if (data['errors'] != null) {
        final errors = data['errors'] as Map;
        final firstKey = errors.keys.first;
        final firstErrorList = errors[firstKey] as List;
        if (firstErrorList.isNotEmpty) {
          errorMessage = firstErrorList.first.toString();
        }
      }
    }

    debugPrint('🔴 Dio Error (${e.response?.statusCode}): $errorMessage');

    return CustomDioError(
      message: errorMessage,
      statusCode: e.response?.statusCode,
      originalException: e,
    );
  }
}

// ─── Duplicate Request Guard ────────────────────────────────────────────────

/// Coalesces duplicate in-flight GET requests so identical concurrent
/// calls share a single network round-trip.
class DuplicateRequestInterceptor extends Interceptor {
  final _inFlight = <String, Completer<Response<dynamic>>>{};

  static String _key(RequestOptions o) =>
      '${o.method}::${o.path}::${o.queryParameters}';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method != 'GET') {
      handler.next(options);
      return;
    }
    final key = _key(options);
    final existingCompleter = _inFlight[key];

    if (existingCompleter != null) {
      debugPrint('⚡ DEDUP: coalescing duplicate GET request — ${options.path}');
      unawaited(
        existingCompleter.future.then((res) {
          handler.resolve(
            Response<dynamic>(
              requestOptions: options,
              data: res.data,
              headers: res.headers,
              statusCode: res.statusCode,
              statusMessage: res.statusMessage,
              isRedirect: res.isRedirect,
              redirects: res.redirects,
              extra: res.extra,
            ),
          );
        }).catchError((Object err) {
          if (err is DioException) {
            handler.reject(
              DioException(
                requestOptions: options,
                error: err.error,
                response: err.response,
                type: err.type,
                message: err.message,
              ),
            );
          } else {
            handler.reject(DioException(requestOptions: options, error: err));
          }
        }),
      );
      return;
    }

    _inFlight[key] = Completer<Response<dynamic>>();
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final key = _key(response.requestOptions);
    final completer = _inFlight.remove(key);
    completer?.complete(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final key = _key(err.requestOptions);
    final completer = _inFlight.remove(key);
    completer?.completeError(err);
    handler.next(err);
  }
}

// ─── Error model ─────────────────────────────────────────────────────────────

class CustomDioError implements Exception {
  CustomDioError({
    required this.message,
    required this.originalException,
    this.statusCode,
  });
  final String message;
  final int? statusCode;
  final DioException originalException;

  @override
  String toString() => message;
}
