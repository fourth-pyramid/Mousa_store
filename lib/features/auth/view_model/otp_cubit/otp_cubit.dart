import 'dart:async';

import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/auth/repo/otp_repo.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_state.dart';

class OtpCubit extends SafeCubit<OtpState> {
  OtpCubit({required this.otpRepo, required OtpFlowType flowType})
    : super(OtpState(flowType: flowType));
  final OtpRepo otpRepo;
  Timer? _timer;

  void setOtpCode(String otp) {
    emit(state.copyWith(otpCode: otp));
  }

  void startTimer({int seconds = 600}) {
    _timer?.cancel();
    emit(state.copyWith(remainingSeconds: seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds == 0) {
        timer.cancel();
      } else {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      }
    });
  }

  Future<void> verifyOtp(String email) async {
    emit(state.copyWith(status: OtpStatus.loading));

    final response = state.flowType == OtpFlowType.signup
        ? await otpRepo.verifyOtp(email: email, otp: state.otpCode)
        : await otpRepo.sendCodeForForgetPassword(
            email: email,
            otp: state.otpCode,
          );

    emit(
      state.copyWith(
        status: response.success ? OtpStatus.success : OtpStatus.error,
        message: response.message,
        resetToken: response.token,
      ),
    );
  }

  Future<void> resendOtp(String email) async {
    if (state.remainingSeconds > 0) return;

    emit(state.copyWith(status: OtpStatus.loading));

    final response = state.flowType == OtpFlowType.signup
        ? await otpRepo.resendOtp(email: email)
        : await otpRepo.resendOtpForForgetPassword(email: email);

    if (response.success) startTimer();

    emit(
      state.copyWith(
        status: response.success ? OtpStatus.success : OtpStatus.error,
        message: response.message,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
