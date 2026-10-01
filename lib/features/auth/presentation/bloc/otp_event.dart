import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_event.freezed.dart';

@freezed
sealed class OtpEvent with _$OtpEvent {
  const factory OtpEvent.started({@Default(600) int seconds}) = OtpTimerStarted;
  const factory OtpEvent.timerTicked(int remainingSeconds) = OtpTimerTicked;
  const factory OtpEvent.codeChanged(String code) = OtpCodeChanged;
  const factory OtpEvent.verifySubmitted({required String email}) =
      OtpVerifySubmitted;
  const factory OtpEvent.resendSubmitted({required String email}) =
      OtpResendSubmitted;
}
