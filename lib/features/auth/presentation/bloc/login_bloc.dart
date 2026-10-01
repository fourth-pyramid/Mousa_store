import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/auth/domain/entities/auth_exceptions.dart';
import 'package:mousa_store/features/auth/domain/usecases/login_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/login_event.dart';
import 'package:mousa_store/features/auth/presentation/bloc/login_state.dart';

export 'package:mousa_store/features/auth/presentation/bloc/login_event.dart';
export 'package:mousa_store/features/auth/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(const LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final LoginUseCase _loginUseCase;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      final response = await _loginUseCase(
        email: event.email,
        password: event.password,
      );
      if (response.success) {
        emit(LoginSuccess(response));
      } else {
        emit(LoginFailure(response.message));
      }
    } on EmailNotVerifiedException catch (e) {
      emit(LoginEmailNotVerified(message: e.message));
    } on Object catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
