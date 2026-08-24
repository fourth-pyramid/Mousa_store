import 'package:mousa_store/features/auth/model/user.dart';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.message,
    this.user,
    this.token,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json['status']?.toString() ?? '',
    message: json['message']?.toString() ?? '',
    user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    token: json['token']?.toString(),
    refreshToken: json['refresh_token']?.toString(),
  );
  final String status;
  final String message;
  final User? user;
  final String? token;
  final String? refreshToken;

  bool get success => status.toLowerCase() == 'success';

  bool get isVerified => user?.isVerified ?? false;
}
