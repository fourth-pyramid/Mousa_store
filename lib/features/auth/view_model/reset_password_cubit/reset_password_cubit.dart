import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/repo/reset_password_repo.dart';
import 'package:mousa_store/features/auth/view_model/reset_password_cubit/reset_password_state.dart';

class ResetPasswordCubit extends SafeCubit<ResetPasswordState> {
  ResetPasswordCubit({required this.resetPasswordRepo})
    : super(const ResetPasswordState());
  final ResetPasswordRepo resetPasswordRepo;

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
    required String resetToken,
  }) async {
    if (newPassword != confirmPassword) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          message: 'Passwords do not match',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ResetPasswordStatus.loading));

    final response = await resetPasswordRepo.resetPassword(
      email: email,
      newPassword: newPassword,
      passwordConfirm: confirmPassword,
      resetToken: resetToken,
    );

    emit(
      state.copyWith(
        status: response.success
            ? ResetPasswordStatus.success
            : ResetPasswordStatus.failure,
        message: response.message,
      ),
    );
  }
}
