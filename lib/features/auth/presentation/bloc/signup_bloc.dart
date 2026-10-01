import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/auth/domain/usecases/signup_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/signup_event.dart';
import 'package:mousa_store/features/auth/presentation/bloc/signup_state.dart';

export 'package:mousa_store/features/auth/presentation/bloc/signup_event.dart';
export 'package:mousa_store/features/auth/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required SignupUseCase signupUseCase})
      : _signupUseCase = signupUseCase,
        super(const SignupInitial()) {
    on<SignupSubmitted>(_onSubmitted);
  }

  final SignupUseCase _signupUseCase;

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(const SignupLoading());
    try {
      final response = await _signupUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );
      if (response.success) {
        emit(SignupSuccess(response));
      } else {
        emit(SignupFailure(response.message));
      }
    } on Object catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
