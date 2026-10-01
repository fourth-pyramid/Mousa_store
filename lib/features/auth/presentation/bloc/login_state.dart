import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/auth/data/models/login_response.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.success(LoginResponse data) = LoginSuccess;
  const factory LoginState.emailNotVerified({
    required String message,
  }) = LoginEmailNotVerified;
  const factory LoginState.failure(String error) = LoginFailure;
}
