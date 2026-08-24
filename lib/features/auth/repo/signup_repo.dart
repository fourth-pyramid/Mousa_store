import 'package:mousa_store/features/auth/model/signup_response.dart';
import 'package:mousa_store/features/auth/service/signup_service.dart';

class SignupRepo {
  SignupRepo({required this.signupService});
  final SignupService signupService;

  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final result = await signupService.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    return result;
  }
}
