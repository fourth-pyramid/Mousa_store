import 'package:equatable/equatable.dart';

enum ResetPasswordStatus { idle, loading, success, failure }

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.status = ResetPasswordStatus.idle,
    this.message = '',
  });
  final ResetPasswordStatus status;
  final String message;

  ResetPasswordState copyWith({ResetPasswordStatus? status, String? message}) =>
      ResetPasswordState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, message];
}
