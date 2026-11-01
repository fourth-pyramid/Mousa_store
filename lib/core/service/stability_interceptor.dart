import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';

/// Dio interceptor that measures HTTP request round-trip latency
/// and reports it (as well as network failures) to [IInternetConnectionService]
/// for network stability monitoring.
class StabilityInterceptor extends Interceptor {
  StabilityInterceptor(this._service);

  final IInternetConnectionService _service;

  /// Extra key to skip latency and failure reporting for uploads, downloads,
  /// or long-polling requests.
  static const String skipKey = 'skipStability';
  static const String _startTimeKey = 'stability_startTime';

  bool _shouldSkip(RequestOptions options) => options.extra[skipKey] == true;

  int? _computeLatency(RequestOptions options) {
    final startTime = options.extra[_startTimeKey] as int?;
    if (startTime == null) return null;
    return DateTime.now().millisecondsSinceEpoch - startTime;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_shouldSkip(options)) {
      options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (!_shouldSkip(response.requestOptions)) {
      final latency = _computeLatency(response.requestOptions);
      if (latency != null) {
        _service.reportLatency(latency);
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!_shouldSkip(err.requestOptions)) {
      final latency = _computeLatency(err.requestOptions);
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          if (latency != null) {
            _service.reportLatency(latency);
          }
          _service.reportRequestFailure();
        case DioExceptionType.connectionError:
          _service.reportRequestFailure();
        case DioExceptionType.badResponse:
          if (latency != null) {
            _service.reportLatency(latency);
          }
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
        // ignore: no_default_cases
        default:
          break;
      }
    }
    handler.next(err);
  }
}
