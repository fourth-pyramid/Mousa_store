import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/forgot_password_event.dart';
import 'package:mousa_store/features/auth/presentation/bloc/forgot_password_state.dart';

export 'package:mousa_store/features/auth/presentation/bloc/forgot_password_event.dart';
export 'package:mousa_store/features/auth/presentation/bloc/forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required ForgotPasswordUseCase forgotPasswordUseCase})
      : _forgotPasswordUseCase = forgotPasswordUseCase,
        super(const ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(const ForgotPasswordLoading());
    try {
      final response = await _forgotPasswordUseCase(email: event.email);
      if (response.success) {
        emit(ForgotPasswordSuccess(response: response, email: event.email));
      } else {
        emit(ForgotPasswordFailure(response.message));
      }
    } on Object catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
