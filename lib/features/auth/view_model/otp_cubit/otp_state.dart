import 'package:equatable/equatable.dart';

enum OtpStatus { idle, loading, success, error }

enum OtpFlowType { signup, forgotPassword }

class OtpState extends Equatable {
  const OtpState({
    this.status = OtpStatus.idle,
    this.message = '',
    this.remainingSeconds = 0,
    this.otpCode = '',
    this.flowType = OtpFlowType.signup,
    this.resetToken,
  });
  final OtpStatus status;
  final String message;
  final int remainingSeconds;
  final String otpCode;
  final OtpFlowType flowType;
  final String? resetToken;

  OtpState copyWith({
    OtpStatus? status,
    String? message,
    int? remainingSeconds,
    String? otpCode,
    OtpFlowType? flowType,
    String? resetToken,
  }) => OtpState(
    status: status ?? this.status,
    message: message ?? this.message,
    remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    otpCode: otpCode ?? this.otpCode,
    flowType: flowType ?? this.flowType,
    resetToken: resetToken ?? this.resetToken,
  );

  @override
  List<Object?> get props => [
    status,
    message,
    remainingSeconds,
    otpCode,
    flowType,
    resetToken,
  ];
}
