import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/setting_profile/data/models/profile_update_response.dart';

abstract class SettingProfileRepository {
  Future<User?> getProfile();
  Future<ProfileUpdateResponse> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? oldPassword,
    String? password,
    String? confirmPassword,
  });
}
