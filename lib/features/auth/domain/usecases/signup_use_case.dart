import 'package:mousa_store/features/auth/data/models/signup_response.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  const SignupUseCase(this._repository);
  final AuthRepository _repository;

  Future<SignupResponse> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) => _repository.signup(
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    password: password,
    passwordConfirmation: passwordConfirmation,
  );
}
