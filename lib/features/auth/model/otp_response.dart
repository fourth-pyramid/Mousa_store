class OtpResponse {
  OtpResponse({required this.success, required this.message, this.token});

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    success: (json['success'] as bool?) ?? false,
    message: (json['message'] as String?) ?? '',
    token: json['reset_token'] as String?,
  );
  final bool success;
  final String message;
  final String? token;
}
