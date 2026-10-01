import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_event.freezed.dart';

@freezed
sealed class SignupEvent with _$SignupEvent {
  const factory SignupEvent.submitted({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) = SignupSubmitted;
}
