import 'package:mousa_store/features/auth/model/user.dart';

class ProfileUpdateResponse {
  ProfileUpdateResponse({this.success, this.message, this.data});

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponse(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] != null ? User.fromJson(json['data'] as Map<String, dynamic>) : null,
      );

  final bool? success;
  final String? message;
  final User? data;
}
