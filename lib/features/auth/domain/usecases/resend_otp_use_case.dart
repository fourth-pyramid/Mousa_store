import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUseCase {
  const ResendOtpUseCase(this._repository);
  final AuthRepository _repository;

  Future<OtpResponse> resendSignupOtp({
    required String email,
  }) => _repository.resendOtp(email: email);

  Future<OtpResponse> resendForgotPasswordOtp({
    required String email,
  }) => _repository.resendForgotPasswordOtp(email: email);
}
