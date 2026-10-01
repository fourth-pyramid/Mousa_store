import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this._repository);
  final AuthRepository _repository;

  Future<OtpResponse> verifySignupOtp({
    required String email,
    required String otp,
  }) => _repository.verifyOtp(email: email, otp: otp);

  Future<OtpResponse> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) => _repository.verifyForgotPasswordOtp(email: email, otp: otp);
}
