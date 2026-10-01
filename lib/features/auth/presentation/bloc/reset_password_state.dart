import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';

part 'reset_password_state.freezed.dart';

@freezed
sealed class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = ResetPasswordInitial;
  const factory ResetPasswordState.loading() = ResetPasswordLoading;
  const factory ResetPasswordState.success(OtpResponse response) =
      ResetPasswordSuccess;
  const factory ResetPasswordState.failure(String message) =
      ResetPasswordFailure;
}
