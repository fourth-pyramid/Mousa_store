import 'package:mousa_store/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mousa_store/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mousa_store/features/auth/data/models/login_response.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/data/models/signup_response.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    if (response.success &&
        response.token != null &&
        response.refreshToken != null) {
      await _localDataSource.saveTokens(
        accessToken: response.token!,
        refreshToken: response.refreshToken,
      );
      if (response.user != null) {
        await _localDataSource.saveUser(response.user!);
        await _localDataSource.onUserLoggedIn(
          token: response.token!,
          user: response.user!,
        );
      }
    }

    return response;
  }

  @override
  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) => _remoteDataSource.signup(
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    password: password,
    passwordConfirmation: passwordConfirmation,
  );

  @override
  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  }) => _remoteDataSource.verifyOtp(email: email, otp: otp);

  @override
  Future<OtpResponse> resendOtp({
    required String email,
  }) => _remoteDataSource.resendOtp(email: email);

  @override
  Future<OtpResponse> sendEmailForForgotPassword({
    required String email,
  }) => _remoteDataSource.sendEmailForForgotPassword(email: email);

  @override
  Future<OtpResponse> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) => _remoteDataSource.verifyForgotPasswordOtp(email: email, otp: otp);

  @override
  Future<OtpResponse> resendForgotPasswordOtp({
    required String email,
  }) => _remoteDataSource.resendForgotPasswordOtp(email: email);

  @override
  Future<OtpResponse> resetPassword({
    required String email,
    required String newPassword,
    required String passwordConfirm,
    required String resetToken,
  }) => _remoteDataSource.resetPassword(
    email: email,
    newPassword: newPassword,
    passwordConfirm: passwordConfirm,
    resetToken: resetToken,
  );
}
