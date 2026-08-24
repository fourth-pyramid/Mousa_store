import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/repo/signup_repo.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_state.dart';

class SignupCubit extends SafeCubit<SignupState> {
  SignupCubit({required this.repository}) : super(const SignupState());
  final SignupRepo repository;

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: SignupStatus.loading));

    try {
      final result = await repository.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      emit(state.copyWith(status: SignupStatus.success, result: result));
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
