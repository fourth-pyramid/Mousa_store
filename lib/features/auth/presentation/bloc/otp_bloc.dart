import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/otp_event.dart';
import 'package:mousa_store/features/auth/presentation/bloc/otp_state.dart';

export 'package:mousa_store/features/auth/presentation/bloc/otp_event.dart';
export 'package:mousa_store/features/auth/presentation/bloc/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc({
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
    required OtpFlowType flowType,
  })  : _verifyOtpUseCase = verifyOtpUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        super(OtpState(flowType: flowType)) {
    on<OtpTimerStarted>(_onTimerStarted);
    on<OtpTimerTicked>(_onTimerTicked);
    on<OtpCodeChanged>(_onCodeChanged);
    on<OtpVerifySubmitted>(_onVerifySubmitted);
    on<OtpResendSubmitted>(_onResendSubmitted);
  }

  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  Timer? _timer;

  void _onTimerStarted(OtpTimerStarted event, Emitter<OtpState> emit) {
    _timer?.cancel();
    emit(state.copyWith(remainingSeconds: event.seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        timer.cancel();
        add(const OtpTimerTicked(0));
      } else {
        add(OtpTimerTicked(state.remainingSeconds - 1));
      }
    });
  }

  void _onTimerTicked(OtpTimerTicked event, Emitter<OtpState> emit) {
    emit(state.copyWith(remainingSeconds: event.remainingSeconds));
  }

  void _onCodeChanged(OtpCodeChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpCode: event.code));
  }

  Future<void> _onVerifySubmitted(
    OtpVerifySubmitted event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: OtpStatus.loading));
    try {
      final response = state.flowType == OtpFlowType.signup
          ? await _verifyOtpUseCase.verifySignupOtp(
              email: event.email,
              otp: state.otpCode,
            )
          : await _verifyOtpUseCase.verifyForgotPasswordOtp(
              email: event.email,
              otp: state.otpCode,
            );

      emit(
        state.copyWith(
          status: response.success ? OtpStatus.success : OtpStatus.error,
          message: response.message,
          resetToken: response.token,
        ),
      );
    } on Object catch (e) {
      emit(state.copyWith(status: OtpStatus.error, message: e.toString()));
    }
  }

  Future<void> _onResendSubmitted(
    OtpResendSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    if (state.remainingSeconds > 0) return;

    emit(state.copyWith(status: OtpStatus.loading));
    try {
      final response = state.flowType == OtpFlowType.signup
          ? await _resendOtpUseCase.resendSignupOtp(email: event.email)
          : await _resendOtpUseCase.resendForgotPasswordOtp(
              email: event.email,
            );

      if (response.success) {
        add(const OtpTimerStarted());
      }

      emit(
        state.copyWith(
          status: response.success ? OtpStatus.success : OtpStatus.error,
          message: response.message,
        ),
      );
    } on Object catch (e) {
      emit(state.copyWith(status: OtpStatus.error, message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
