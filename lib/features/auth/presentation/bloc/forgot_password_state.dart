import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';

part 'forgot_password_state.freezed.dart';

@freezed
sealed class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = ForgotPasswordInitial;
  const factory ForgotPasswordState.loading() = ForgotPasswordLoading;
  const factory ForgotPasswordState.success({
    required OtpResponse response,
    required String email,
  }) = ForgotPasswordSuccess;
  const factory ForgotPasswordState.failure(String message) =
      ForgotPasswordFailure;
}
