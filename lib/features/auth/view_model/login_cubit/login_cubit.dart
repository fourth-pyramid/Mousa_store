import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/repo/login_repo.dart';
import 'package:mousa_store/features/auth/service/login_service.dart';
import 'package:mousa_store/features/auth/view_model/login_cubit/login_state.dart';

class LoginCubit extends SafeCubit<LoginState> {
  LoginCubit({required this.loginRepo}) : super(const LoginState());

  final LoginRepo loginRepo;

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final response = await loginRepo.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.success, data: response));
    } on EmailNotVerifiedException catch (e) {
      emit(
        state.copyWith(status: LoginStatus.emailNotVerified, error: e.message),
      );
    } on Object catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
    }
  }
}
