import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DioHelper & CustomDioError Tests', () {
    test('CustomDioError retains message and status code', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
        ),
      );

      final customError = CustomDioError(
        message: 'Not Found',
        statusCode: 404,
        originalException: dioException,
      );

      expect(customError.message, equals('Not Found'));
      expect(customError.statusCode, equals(404));
      expect(customError.toString(), equals('Not Found'));
    });

    test('DuplicateRequestInterceptor passes non-GET requests immediately', () {
      final interceptor = DuplicateRequestInterceptor();

      final options = RequestOptions(
        path: '/orders',
        method: 'POST',
        data: {'item_id': 1},
      );

      interceptor.onRequest(
        options,
        RequestInterceptorHandler(),
      );

      // Verify no exceptions were thrown
      expect(options.method, equals('POST'));
    });
  });
}
