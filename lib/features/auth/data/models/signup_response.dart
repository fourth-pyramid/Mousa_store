class SignupResponse {
  SignupResponse({required this.success, required this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
    success: (json['success'] as bool?) ?? false,
    message: (json['message'] as String?) ?? '',
  );
  final bool success;
  final String message;
}
