import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/auth/model/login_response.dart';

enum LoginStatus { initial, loading, success, failure, emailNotVerified }

class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.initial, this.error, this.data});
  final LoginStatus status;
  final String? error;
  final LoginResponse? data;

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    LoginResponse? data,
  }) => LoginState(
    status: status ?? this.status,
    error: error,
    data: data ?? this.data,
  );

  @override
  List<Object?> get props => [status, error, data];
}
