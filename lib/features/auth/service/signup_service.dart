import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/model/signup_response.dart';

class SignupService {
  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'register',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      return SignupResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
