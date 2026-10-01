import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/setting_profile/data/datasources/profile_remote_data_source.dart';
import 'package:mousa_store/features/setting_profile/data/models/profile_update_response.dart';
import 'package:mousa_store/features/setting_profile/domain/repositories/setting_profile_repository.dart';

class SettingProfileRepositoryImpl implements SettingProfileRepository {
  const SettingProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<User?> getProfile() => _remoteDataSource.getProfile();

  @override
  Future<ProfileUpdateResponse> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? oldPassword,
    String? password,
    String? confirmPassword,
  }) =>
      _remoteDataSource.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        oldPassword: oldPassword,
        password: password,
        confirmPassword: confirmPassword,
      );
}
