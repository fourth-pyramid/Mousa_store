import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/auth/domain/entities/user.dart';

part 'auth_result.freezed.dart';

@freezed
abstract class AuthResult with _$AuthResult {
  const AuthResult._();

  const factory AuthResult({
    required String status,
    required String message,
    User? user,
    String? token,
    String? refreshToken,
  }) = _AuthResult;

  bool get success => status.toLowerCase() == 'success';
  bool get isVerified => user?.isVerified ?? false;
}
