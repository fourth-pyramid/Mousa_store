import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<OtpResponse> call({
    required String email,
    required String newPassword,
    required String passwordConfirm,
    required String resetToken,
  }) => _repository.resetPassword(
    email: email,
    newPassword: newPassword,
    passwordConfirm: passwordConfirm,
    resetToken: resetToken,
  );
}
