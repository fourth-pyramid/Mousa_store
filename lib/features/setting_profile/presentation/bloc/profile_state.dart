import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/auth/data/models/user.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.loaded(User user) = ProfileLoaded;
  const factory ProfileState.updating() = ProfileUpdating;
  const factory ProfileState.updated(User user, String message) = ProfileUpdated;
  const factory ProfileState.error(String message) = ProfileError;
}
