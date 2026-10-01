import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.fetchRequested() = ProfileFetchRequested;
  const factory ProfileEvent.nameUpdated({
    String? firstName,
    String? lastName,
  }) = ProfileNameUpdated;
  const factory ProfileEvent.emailUpdated({
    required String email,
  }) = ProfileEmailUpdated;
  const factory ProfileEvent.phoneUpdated({
    required String phone,
  }) = ProfilePhoneUpdated;
  const factory ProfileEvent.passwordChanged({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) = ProfilePasswordChanged;
}
