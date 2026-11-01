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
    test('Stamps startTime in options.extra and calls handler.next once', () {
      final options = RequestOptions(path: '/test');
      final handler = MockRequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      expect(options.extra.containsKey('stability_startTime'), isTrue);
      expect(options.extra['stability_startTime'], isA<int>());
      verify(() => handler.next(options)).called(1);
    });

    test('Reports latency on onResponse and calls handler.next once', () {
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
      verifyNever(() => mockService.reportRequestFailure());
      verify(() => handler.next(response)).called(1);
    });

    test('cancel -> reports nothing and calls handler.next once', () {
      final startTime = DateTime.now().millisecondsSinceEpoch - 150;
      final options = RequestOptions(
        path: '/test',
        extra: {'stability_startTime': startTime},
      );
      final err = DioException(
        requestOptions: options,
        type: DioExceptionType.cancel,
      );
      final handler = MockErrorInterceptorHandler();

      interceptor.onError(err, handler);

      verifyNever(() => mockService.reportLatency(any()));
      verifyNever(() => mockService.reportRequestFailure());
      verify(() => handler.next(err)).called(1);
    });

    test(
      'timeouts (connection/send/receive) -> report latency + reportRequestFailure and call handler.next once',
      () {
        for (final timeoutType in [
          DioExceptionType.connectionTimeout,
          DioExceptionType.sendTimeout,
          DioExceptionType.receiveTimeout,
        ]) {
          reset(mockService);
          final startTime = DateTime.now().millisecondsSinceEpoch - 300;
          final options = RequestOptions(
            path: '/test',
            extra: {'stability_startTime': startTime},
          );
          final err = DioException(requestOptions: options, type: timeoutType);
          final handler = MockErrorInterceptorHandler();

          interceptor.onError(err, handler);

          verify(
            () =>
                mockService.reportLatency(any(that: greaterThanOrEqualTo(250))),
          ).called(1);
          verify(() => mockService.reportRequestFailure()).called(1);
          verify(() => handler.next(err)).called(1);
        }
      },
    );

    test(
      'connectionError -> calls reportRequestFailure only (no latency) and handler.next once',
      () {
        final startTime = DateTime.now().millisecondsSinceEpoch - 50;
        final options = RequestOptions(
          path: '/test',
          extra: {'stability_startTime': startTime},
        );
        final err = DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        );
        final handler = MockErrorInterceptorHandler();

        interceptor.onError(err, handler);

        verifyNever(() => mockService.reportLatency(any()));
        verify(() => mockService.reportRequestFailure()).called(1);
        verify(() => handler.next(err)).called(1);
      },
    );

    test(
      'badResponse -> reports latency only (no request failure) and calls handler.next once',
      () {
        final startTime = DateTime.now().millisecondsSinceEpoch - 200;
        final options = RequestOptions(
          path: '/test',
          extra: {'stability_startTime': startTime},
        );
        final err = DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(requestOptions: options, statusCode: 500),
        );
        final handler = MockErrorInterceptorHandler();

        interceptor.onError(err, handler);

        verify(
          () => mockService.reportLatency(any(that: greaterThanOrEqualTo(150))),
        ).called(1);
        verifyNever(() => mockService.reportRequestFailure());
        verify(() => handler.next(err)).called(1);
      },
    );

    test(
      'badCertificate and unknown -> report nothing and call handler.next once',
      () {
        for (final type in [
          DioExceptionType.badCertificate,
          DioExceptionType.unknown,
        ]) {
          reset(mockService);
          final startTime = DateTime.now().millisecondsSinceEpoch - 100;
          final options = RequestOptions(
            path: '/test',
            extra: {'stability_startTime': startTime},
          );
          final err = DioException(requestOptions: options, type: type);
          final handler = MockErrorInterceptorHandler();

          interceptor.onError(err, handler);

          verifyNever(() => mockService.reportLatency(any()));
          verifyNever(() => mockService.reportRequestFailure());
          verify(() => handler.next(err)).called(1);
        }
      },
    );

    test(
      'skipStability -> skips reporting on onRequest, onResponse, and onError while calling handler.next once',
      () {
        final options = RequestOptions(
          path: '/upload',
          extra: {StabilityInterceptor.skipKey: true},
        );
        final reqHandler = MockRequestInterceptorHandler();
        interceptor.onRequest(options, reqHandler);
        expect(options.extra.containsKey('stability_startTime'), isFalse);
        verify(() => reqHandler.next(options)).called(1);

        options.extra['stability_startTime'] =
            DateTime.now().millisecondsSinceEpoch - 500;

        final response = Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
        );
        final resHandler = MockResponseInterceptorHandler();
        interceptor.onResponse(response, resHandler);
        verifyNever(() => mockService.reportLatency(any()));
        verify(() => resHandler.next(response)).called(1);

        final err = DioException(
          requestOptions: options,
          type: DioExceptionType.connectionTimeout,
        );
        final errHandler = MockErrorInterceptorHandler();
        interceptor.onError(err, errHandler);
        verifyNever(() => mockService.reportLatency(any()));
        verifyNever(() => mockService.reportRequestFailure());
        verify(() => errHandler.next(err)).called(1);
      },
    );
  });
}
