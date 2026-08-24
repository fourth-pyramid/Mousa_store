import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/setting_profile/service/profile_service.dart';

part 'profile_state.dart';

class ProfileCubit extends SafeCubit<ProfileState> {
  ProfileCubit(this._profileService) : super(ProfileInitial());

  final ProfileService _profileService;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final user = await _profileService.getProfile();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('Failed to load profile'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// تحديث الاسم الأول والأخير فقط
  Future<void> updateName({String? firstName, String? lastName}) async {
    emit(ProfileUpdating());
    try {
      final response = await _profileService.updateProfile(
        firstName: firstName,
        lastName: lastName,
      );

      if ((response.success ?? false) && response.data != null) {
        final authService = getIt<AuthService>();
        await authService.updateUser(response.data!);

        emit(ProfileUpdated(response.data!, response.message!));
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// تحديث البريد فقط
  Future<void> updateEmail({required String email}) async {
    emit(ProfileUpdating());
    try {
      final response = await _profileService.updateProfile(email: email);

      if ((response.success ?? false) && response.data != null) {
        final authService = getIt<AuthService>();
        await authService.updateUser(response.data!);

        emit(ProfileUpdated(response.data!, response.message!));
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// تحديث رقم الهاتف فقط
  Future<void> updatePhone({required String phone}) async {
    emit(ProfileUpdating());
    try {
      final response = await _profileService.updateProfile(phone: phone);

      if ((response.success ?? false) && response.data != null) {
        final authService = getIt<AuthService>();
        await authService.updateUser(response.data!);

        emit(ProfileUpdated(response.data!, response.message!));
      } else {
        emit(ProfileError(response.message ?? 'Unknown Error'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// تغيير كلمة المرور
  Future<void> changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ProfileUpdating());
    try {
      final response = await _profileService.updateProfile(
        oldPassword: oldPassword,
        password: password,
        confirmPassword: confirmPassword,
      );

      if ((response.success ?? false) && response.data != null) {
        final authService = getIt<AuthService>();
        await authService.updateUser(response.data!);

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
