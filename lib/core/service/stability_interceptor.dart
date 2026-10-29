import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';

/// Dio interceptor that measures HTTP request round-trip latency
/// and reports it to [IInternetConnectionService] for network stability monitoring.
class StabilityInterceptor extends Interceptor {
  StabilityInterceptor(this._service);

  final IInternetConnectionService _service;

  static const String _startTimeKey = 'stability_startTime';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final startTime = response.requestOptions.extra[_startTimeKey] as int?;
    if (startTime != null) {
      final latency = DateTime.now().millisecondsSinceEpoch - startTime;
      _service.reportLatency(latency);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra[_startTimeKey] as int?;
    if (startTime != null) {
      final latency = DateTime.now().millisecondsSinceEpoch - startTime;
      _service.reportLatency(latency);
    }
    handler.next(err);
  }
}
