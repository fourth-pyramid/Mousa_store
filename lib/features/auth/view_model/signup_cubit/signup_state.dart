import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/auth/model/signup_response.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  const SignupState({
    this.status = SignupStatus.initial,
    this.response,
    this.errorMessage,
  });
  final SignupStatus status;
  final SignupResponse? response;
  final String? errorMessage;

  SignupState copyWith({
    SignupStatus? status,
    SignupResponse? result,
    String? errorMessage,
  }) => SignupState(
    status: status ?? this.status,
    response: result ?? response,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, response, errorMessage];
}
