import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/service/stability_interceptor.dart';

class MockInternetConnectionService extends Mock
    implements IInternetConnectionService {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  late MockInternetConnectionService mockService;
  late StabilityInterceptor interceptor;

  setUp(() {
    mockService = MockInternetConnectionService();
    interceptor = StabilityInterceptor(mockService);
  });

  group('StabilityInterceptor Tests', () {
    test('Stamps startTime in options.extra and calls handler.next', () {
      final options = RequestOptions(path: '/test');
      final handler = MockRequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      expect(options.extra.containsKey('stability_startTime'), isTrue);
      expect(options.extra['stability_startTime'], isA<int>());
      verify(() => handler.next(options)).called(1);
    });

    test('Reports latency on onResponse and passes to handler.next', () {
      final startTime = DateTime.now().millisecondsSinceEpoch - 120;
      final options = RequestOptions(
        path: '/test',
        extra: {'stability_startTime': startTime},
      );
      final response = Response<dynamic>(
        requestOptions: options,
        statusCode: 200,
      );
      final handler = MockResponseInterceptorHandler();

      interceptor.onResponse(response, handler);

      verify(
        () => mockService.reportLatency(any(that: greaterThanOrEqualTo(100))),
      ).called(1);
      verify(() => handler.next(response)).called(1);
    });

    test('Reports latency on onError and passes to handler.next', () {
      final startTime = DateTime.now().millisecondsSinceEpoch - 250;
      final options = RequestOptions(
        path: '/test',
        extra: {'stability_startTime': startTime},
      );
      final dioException = DioException(
        requestOptions: options,
        error: 'Network failure',
      );
      final handler = MockErrorInterceptorHandler();

      interceptor.onError(dioException, handler);

      verify(
        () => mockService.reportLatency(any(that: greaterThanOrEqualTo(200))),
      ).called(1);
      verify(() => handler.next(dioException)).called(1);
    });

    test('Ignores latency reporting if startTime is missing', () {
      final options = RequestOptions(path: '/test');
      final response = Response<dynamic>(
        requestOptions: options,
        statusCode: 200,
      );
      final handler = MockResponseInterceptorHandler();

      interceptor.onResponse(response, handler);

      verifyNever(() => mockService.reportLatency(any()));
      verify(() => handler.next(response)).called(1);
    });
  });
}
