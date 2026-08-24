import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/model/otp_response.dart';

class ResetPasswordService {
  static Future<OtpResponse> resetPassword({
    required String email,
    required String newPassword,
    required String passwordConfirm,
    required String resetToken,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'password',
        data: {
          'email': email,
          'password': newPassword,
          'password_confirmation': passwordConfirm,
          'reset_token': resetToken,
        },
      );

      return OtpResponse.fromJson(response.data as Map<String, dynamic>);
    } on Object catch (e) {
      return OtpResponse(
        success: false,
        message: 'Failed to reset password: $e',
      );
    }
  }
}
