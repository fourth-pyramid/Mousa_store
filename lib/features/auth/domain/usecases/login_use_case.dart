import 'package:mousa_store/features/auth/data/models/login_response.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<LoginResponse> call({
    required String email,
    required String password,
  }) => _repository.login(email: email, password: password);
}
