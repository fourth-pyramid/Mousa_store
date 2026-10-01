import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/auth/data/models/signup_response.dart';

part 'signup_state.freezed.dart';

@freezed
sealed class SignupState with _$SignupState {
  const factory SignupState.initial() = SignupInitial;
  const factory SignupState.loading() = SignupLoading;
  const factory SignupState.success(SignupResponse data) = SignupSuccess;
  const factory SignupState.failure(String error) = SignupFailure;
}
