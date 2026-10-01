import 'package:mousa_store/features/auth/data/models/user.dart';

/// Lightweight response object from the profile update endpoint.
class ProfileUpdateResponse {
  ProfileUpdateResponse({this.success, this.message, this.data});

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponse(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] != null
            ? User.fromJson(json['data'] as Map<String, dynamic>)
            : null,
      );

  final bool? success;
  final String? message;
  final User? data;
}
