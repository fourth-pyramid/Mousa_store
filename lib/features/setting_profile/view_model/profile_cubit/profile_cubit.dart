import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/setting_profile/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends SafeCubit<ProfileState> {
  ProfileCubit({
    required ProfileRepo profileRepo,
    required AuthService authService,
  }) : _profileRepo = profileRepo,
       _authService = authService,
       super(const ProfileInitial());

  final ProfileRepo _profileRepo;
  final AuthService _authService;

  Future<void> getProfile() async {
    emit(const ProfileLoading());
    try {
      final user = await _profileRepo.getProfile();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(const ProfileError('Failed to load profile'));
      }
    } on Object catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// تحديث الاسم الأول والأخير فقط
  Future<void> updateName({String? firstName, String? lastName}) async {
    emit(const ProfileUpdating());
    try {
      final response = await _profileRepo.updateProfile(
        firstName: firstName,
        lastName: lastName,
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

  /// تحديث البريد فقط
  Future<void> updateEmail({required String email}) async {
    emit(const ProfileUpdating());
    try {
      final response = await _profileRepo.updateProfile(email: email);

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

  /// تحديث رقم الهاتف فقط
  Future<void> updatePhone({required String phone}) async {
    emit(const ProfileUpdating());
    try {
      final response = await _profileRepo.updateProfile(phone: phone);

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

  /// تغيير كلمة المرور
  Future<void> changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    emit(const ProfileUpdating());
    try {
      final response = await _profileRepo.updateProfile(
        oldPassword: oldPassword,
        password: password,
        confirmPassword: confirmPassword,
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
