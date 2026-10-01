import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/reset_password_event.dart';
import 'package:mousa_store/features/auth/presentation/bloc/reset_password_state.dart';

export 'package:mousa_store/features/auth/presentation/bloc/reset_password_event.dart';
export 'package:mousa_store/features/auth/presentation/bloc/reset_password_state.dart';

class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({required ResetPasswordUseCase resetPasswordUseCase})
      : _resetPasswordUseCase = resetPasswordUseCase,
        super(const ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (event.newPassword != event.passwordConfirm) {
      emit(const ResetPasswordFailure('Passwords do not match'));
      return;
    }

    emit(const ResetPasswordLoading());
    try {
      final response = await _resetPasswordUseCase(
        email: event.email,
        newPassword: event.newPassword,
        passwordConfirm: event.passwordConfirm,
        resetToken: event.resetToken,
      );
      if (response.success) {
        emit(ResetPasswordSuccess(response));
      } else {
        emit(ResetPasswordFailure(response.message));
      }
    } on Object catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
