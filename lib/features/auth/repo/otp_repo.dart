import 'package:mousa_store/features/auth/model/otp_response.dart';
import 'package:mousa_store/features/auth/service/otp_service.dart';

class OtpRepo {
  OtpRepo({required this.otpService});
  final OtpService otpService;

  Future<OtpResponse> resendOtp({required String email}) async =>
      otpService.resendOtp(email: email);

  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  }) async => otpService.verifyOtp(email: email, otp: otp);

  Future<OtpResponse> sendEmailForForgetPassword({
    required String email,
  }) async => otpService.sendEmailForForgetPassword(email: email);

  Future<OtpResponse> sendCodeForForgetPassword({
    required String email,
    required String otp,
  }) async =>
      otpService.sendCodeForForgetPassword(email: email, otp: otp);

  Future<OtpResponse> resendOtpForForgetPassword({
    required String email,
  }) async => otpService.resendOtpForForgetPassword(email: email);
}
