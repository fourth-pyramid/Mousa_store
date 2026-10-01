import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_message_result.freezed.dart';

@freezed
abstract class AuthMessageResult with _$AuthMessageResult {
  const factory AuthMessageResult({
    required bool success,
    required String message,
    String? token,
  }) = _AuthMessageResult;
}
