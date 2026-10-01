import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String firstName,
    required String lastName,
    required String userType,
    required String email,
    required String phone,
    required bool isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;
}
