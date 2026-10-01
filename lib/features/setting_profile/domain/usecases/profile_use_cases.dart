import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/setting_profile/data/models/profile_update_response.dart';
import 'package:mousa_store/features/setting_profile/domain/repositories/setting_profile_repository.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this._repository);
  final SettingProfileRepository _repository;

  Future<User?> call() => _repository.getProfile();
}

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);
  final SettingProfileRepository _repository;

  Future<ProfileUpdateResponse> call({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? oldPassword,
    String? password,
    String? confirmPassword,
  }) =>
      _repository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        oldPassword: oldPassword,
        password: password,
        confirmPassword: confirmPassword,
      );
}
