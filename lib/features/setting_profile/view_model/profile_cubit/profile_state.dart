part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

final class ProfileError extends ProfileState {
  const ProfileError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class ProfileUpdating extends ProfileState {
  const ProfileUpdating();
}

final class ProfileUpdated extends ProfileState {
  const ProfileUpdated(this.user, this.message);
  final User user;
  final String message;

  @override
  List<Object?> get props => [user, message];
}
