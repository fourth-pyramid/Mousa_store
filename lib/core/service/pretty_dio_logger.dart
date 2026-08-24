import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PrettyDioLogger extends Interceptor {
  // ponytail: simple int counter avoids any external dependency
  static int _requestCounter = 0;
  final _startTimes = <String, DateTime>{};

  static String _timestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}.'
        '${now.millisecond.toString().padLeft(3, '0')}';
  }

  static String _requestKey(RequestOptions o) =>
      '${o.method}::${o.uri}::${o.hashCode}';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final id = ++_requestCounter;
    options.extra['_reqId'] = id;
    _startTimes[_requestKey(options)] = DateTime.now();

    _print('┌── ☁️  REQUEST #$id [${_timestamp()}]');
    _print('│ ${options.method} ${options.uri}');
    if (options.data != null) {
      _print('│ Body:');
      _printJson(options.data, prefix: '│   ');
    }
    _print('└────────────────────────────────────────');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final id = response.requestOptions.extra['_reqId'] ?? '?';
    final elapsed = _elapsed(response.requestOptions);
    final code = response.statusCode ?? 0;
    final icon = code < 300 ? '✅' : (code < 500 ? '⚠️' : '🔴');

    _print('┌── $icon RESPONSE #$id [$code] +${elapsed}ms [${_timestamp()}]');
    _print('│ ${response.requestOptions.uri}');
    _print(
      '│ Size: ${_bodySize(response.data)}',
    );
    _print('└────────────────────────────────────────');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final id = err.requestOptions.extra['_reqId'] ?? '?';
    final elapsed = _elapsed(err.requestOptions);
    final code = err.response?.statusCode ?? 'ERR';

    // Don't log cancelled requests as errors — they're intentional
    if (err.type == DioExceptionType.cancel) {
      _print('🚫 CANCELLED #$id +${elapsed}ms — ${err.requestOptions.uri}');
      super.onError(err, handler);
      return;
    }

    _print('┌── 🔴 ERROR #$id [$code] +${elapsed}ms [${_timestamp()}]');
    _print('│ ${err.requestOptions.uri}');
    _print('│ ${err.message}');
    if (err.response?.data != null) {
      _printJson(err.response?.data, prefix: '│   ');
    }
    _print('└────────────────────────────────────────');
    super.onError(err, handler);
  }

  // ─── helpers ───────────────────────────────────────────────────────────────

  int _elapsed(RequestOptions options) {
    final start = _startTimes.remove(_requestKey(options));
    if (start == null) return 0;
    return DateTime.now().difference(start).inMilliseconds;
  }

  static String _bodySize(Object? data) {
    if (data == null) return '0 B';
    try {
      final bytes = utf8.encode(data is String ? data : jsonEncode(data));
      final kb = bytes.length / 1024;
      return kb < 1
          ? '${bytes.length} B'
          : '${kb.toStringAsFixed(1)} KB';
    } on Object catch (_) {
      return '? B';
    }
  }

  void _print(String text) => debugPrint(text);

  void _printJson(Object? json, {String prefix = ''}) {
    if (json is Map || json is List) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        encoder.convert(json).split('\n').forEach((l) => _print('$prefix$l'));
      } on Object catch (_) {
        _print('$prefix$json');
      }
    } else {
      _print('$prefix$json');
    }
  }
}
