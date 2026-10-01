import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.freezed.dart';

enum OtpStatus { idle, loading, success, error }

enum OtpFlowType { signup, forgotPassword }

@freezed
sealed class OtpState with _$OtpState {
  const factory OtpState({
    @Default(OtpFlowType.signup) OtpFlowType flowType,
    @Default(OtpStatus.idle) OtpStatus status,
    @Default(0) int remainingSeconds,
    @Default('') String otpCode,
    @Default('') String message,
    String? resetToken,
  }) = _OtpState;
}
