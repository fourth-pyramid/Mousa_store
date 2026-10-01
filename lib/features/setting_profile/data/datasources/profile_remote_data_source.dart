import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/setting_profile/data/models/profile_update_response.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileUpdateResponse> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? oldPassword,
    String? password,
    String? confirmPassword,
  });

  Future<User?> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileUpdateResponse> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? oldPassword,
    String? password,
    String? confirmPassword,
  }) async {
    final data = <String, dynamic>{};

    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;

    if (password != null && password.isNotEmpty) {
      data['current_password'] = oldPassword;
      data['password'] = password;
      data['password_confirmation'] = confirmPassword;
    }

    try {
      final response = await DioHelper.postData(url: 'update-profile', data: data);
      return ProfileUpdateResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on Exception catch (e) {
      return ProfileUpdateResponse(success: false, message: e.toString());
    }
  }

  @override
  Future<User?> getProfile() async => CacheHelper.getUser();
}
