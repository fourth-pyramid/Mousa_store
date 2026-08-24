import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/repo/otp_repo.dart';
import 'package:mousa_store/features/auth/view_model/forgot_password_cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends SafeCubit<ForgotPasswordState> {
  ForgotPasswordCubit({required this.otpRepo})
    : super(const ForgotPasswordState());

  final OtpRepo otpRepo;

  Future<void> sendEmail(String email) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading, email: email));

    final response = await otpRepo.sendEmailForForgetPassword(email: email);

    emit(
      state.copyWith(
        status: response.success
            ? ForgotPasswordStatus.success
            : ForgotPasswordStatus.failure,
        message: response.message,
      ),
    );
  }
}
