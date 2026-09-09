import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/setting_profile/model/profile_update_response.dart';
import 'package:mousa_store/features/setting_profile/service/profile_service.dart';

class ProfileRepo {
  ProfileRepo({required ProfileService service}) : _service = service;

  final ProfileService _service;

  Future<User?> getProfile() => _service.getProfile();

  Future<ProfileUpdateResponse> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? oldPassword,
    String? password,
    String? confirmPassword,
  }) => _service.updateProfile(
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    oldPassword: oldPassword,
    password: password,
    confirmPassword: confirmPassword,
  );
}
