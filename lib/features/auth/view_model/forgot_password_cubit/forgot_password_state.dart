import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.message = '',
    this.email = '',
  });

  final ForgotPasswordStatus status;
  final String message;
  final String email;

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? message,
    String? email,
  }) => ForgotPasswordState(
    status: status ?? this.status,
    message: message ?? this.message,
    email: email ?? this.email,
  );

  @override
  List<Object?> get props => [status, message, email];
}
