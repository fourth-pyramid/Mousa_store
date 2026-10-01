import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/data/models/login_response.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/data/models/signup_response.dart';
import 'package:mousa_store/features/auth/domain/entities/auth_exceptions.dart';

abstract class AuthRemoteDataSource {
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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  @override
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

  @override
  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
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

    final json = response.data as Map<String, dynamic>;
    return SignupResponse.fromJson(json);
  }

  @override
  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await DioHelper.postData(
      url: 'verify-email',
      data: {'email': email, 'otp': otp},
    );
    final json = response.data as Map<String, dynamic>;
    return OtpResponse.fromJson(json);
  }

  @override
  Future<OtpResponse> resendOtp({
    required String email,
  }) async {
    final response = await DioHelper.postData(
      url: 'resend-verify-email',
      data: {'email': email},
    );
    final json = response.data as Map<String, dynamic>;
    return OtpResponse.fromJson(json);
  }

  @override
  Future<OtpResponse> sendEmailForForgotPassword({
    required String email,
  }) async {
    final response = await DioHelper.postData(
      url: 'forget-password',
      data: {'email': email},
    );
    final json = response.data as Map<String, dynamic>;
    return OtpResponse.fromJson(json);
  }

  @override
  Future<OtpResponse> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final response = await DioHelper.postData(
      url: 'send-code-forget-password',
      data: {'email': email, 'otp': otp},
    );
    final json = response.data as Map<String, dynamic>;
    return OtpResponse.fromJson(json);
  }

  @override
  Future<OtpResponse> resendForgotPasswordOtp({
    required String email,
  }) async {
    final response = await DioHelper.postData(
      url: 'resend-code-forget-password',
      data: {'email': email},
    );
    final json = response.data as Map<String, dynamic>;
    return OtpResponse.fromJson(json);
  }

  @override
  Future<OtpResponse> resetPassword({
    required String email,
    required String newPassword,
    required String passwordConfirm,
    required String resetToken,
  }) async {
    final response = await DioHelper.postData(
      url: 'reset-password',
      data: {
        'email': email,
        'password': newPassword,
        'password_confirmation': passwordConfirm,
        'reset_token': resetToken,
      },
    );
    final json = response.data as Map<String, dynamic>;
    return OtpResponse.fromJson(json);
  }
}
