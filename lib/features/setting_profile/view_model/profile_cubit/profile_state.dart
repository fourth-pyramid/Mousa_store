part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  ProfileError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ProfileUpdating extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileUpdated extends ProfileState {
  ProfileUpdated(this.user, this.message);
  final User user;
  final String message;

  @override
  List<Object?> get props => [user, message];
}
