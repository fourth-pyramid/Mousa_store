import 'package:mousa_store/features/auth/data/models/login_response.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/data/models/signup_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  });

  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  });

  Future<OtpResponse> resendOtp({
    required String email,
  });

  Future<OtpResponse> sendEmailForForgotPassword({
    required String email,
  });

  Future<OtpResponse> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<OtpResponse> resendForgotPasswordOtp({
    required String email,
  });

  Future<OtpResponse> resetPassword({
    required String email,
    required String newPassword,
    required String passwordConfirm,
    required String resetToken,
  });
}
