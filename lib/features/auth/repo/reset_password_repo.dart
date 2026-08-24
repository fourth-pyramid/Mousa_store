import 'package:mousa_store/features/auth/model/otp_response.dart';
import 'package:mousa_store/features/auth/service/reset_password_service.dart';

class ResetPasswordRepo {
  ResetPasswordRepo({required this.resetPasswordService});
  final ResetPasswordService resetPasswordService;

  Future<OtpResponse> resetPassword({
    required String email,
    required String newPassword,
    required String passwordConfirm,
    required String resetToken,
  }) async => ResetPasswordService.resetPassword(
    email: email,
    newPassword: newPassword,
    passwordConfirm: passwordConfirm,
    resetToken: resetToken,
  );
}
