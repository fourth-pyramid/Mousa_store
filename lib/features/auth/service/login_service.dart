import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/model/login_response.dart';

class EmailNotVerifiedException implements Exception {
  EmailNotVerifiedException(this.message);
  final String message;

  @override
  String toString() => message;
}

class LoginService {
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'login',
        data: {'email': email, 'password': password},
      );

      final json = response.data;
      if (json is! Map<String, dynamic>) {
        throw Exception('Invalid response format from server');
      }

      final loginResponse = LoginResponse.fromJson(json);

      if (loginResponse.status == 'error' &&
          loginResponse.message == 'Please verify your email first') {
        throw EmailNotVerifiedException(loginResponse.message);
      }

      return loginResponse;
    } on CustomDioError catch (e) {
      if (e.message == 'Please verify your email first') {
        throw EmailNotVerifiedException(e.message);
      }
      throw Exception(e.message);
    } catch (e) {
      if (e is EmailNotVerifiedException) {
        rethrow;
      }
      throw Exception(e.toString());
    }
  }

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await CacheHelper.saveToken(accessToken);
    if (refreshToken != null) {
      await CacheHelper.saveRefreshToken(refreshToken);
    }
    DioHelper.setToken(accessToken);
  }
}
