import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/features/setting_profile/domain/usecases/profile_use_cases.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/profile_event.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/profile_state.dart';

export 'package:mousa_store/features/setting_profile/presentation/bloc/profile_event.dart';
export 'package:mousa_store/features/setting_profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required AuthService authService,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        _authService = authService,
        super(const ProfileInitial()) {
    on<ProfileFetchRequested>(_onFetchRequested);
    on<ProfileNameUpdated>(_onNameUpdated);
    on<ProfileEmailUpdated>(_onEmailUpdated);
    on<ProfilePhoneUpdated>(_onPhoneUpdated);
    on<ProfilePasswordChanged>(_onPasswordChanged);
  }

  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final AuthService _authService;

  Future<void> _onFetchRequested(
    ProfileFetchRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final user = await _getProfileUseCase();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(const ProfileError('Failed to load profile'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onNameUpdated(
    ProfileNameUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      final response = await _updateProfileUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
      );
      if ((response.success ?? false) && response.data != null) {
        await _authService.updateUser(response.data!);
        emit(ProfileUpdated(response.data!, response.message ?? ''));
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onEmailUpdated(
    ProfileEmailUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      final response = await _updateProfileUseCase(email: event.email);
      if ((response.success ?? false) && response.data != null) {
        await _authService.updateUser(response.data!);
        emit(ProfileUpdated(response.data!, response.message ?? ''));
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onPhoneUpdated(
    ProfilePhoneUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      final response = await _updateProfileUseCase(phone: event.phone);
      if ((response.success ?? false) && response.data != null) {
        await _authService.updateUser(response.data!);
        emit(ProfileUpdated(response.data!, response.message ?? ''));
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onPasswordChanged(
    ProfilePasswordChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      final response = await _updateProfileUseCase(
        oldPassword: event.oldPassword,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      if ((response.success ?? false) && response.data != null) {
        await _authService.updateUser(response.data!);
        emit(
          ProfileUpdated(
            response.data!,
            response.message ?? 'تم تغيير كلمة المرور بنجاح',
          ),
        );
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
