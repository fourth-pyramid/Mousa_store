import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/auth/auth_view.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_cubit.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_state.dart';
import 'package:mousa_store/features/auth/widgets/forget_password/reset_password_view.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpView extends StatelessWidget {
  const OtpView({
    required this.email,
    this.flowType = OtpFlowType.signup,
    super.key,
  });
  final String email;
  final OtpFlowType flowType;

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<OtpCubit>(param1: flowType)..startTimer(),
    child: Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 24.w,
          vertical: 24.h,
        ),
        child: BlocConsumer<OtpCubit, OtpState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == OtpStatus.success) {
              if (state.flowType == OtpFlowType.forgotPassword) {
                unawaited(
                  navigateWithTransition<void>(
                    type: TransitionType.fade,
                    context,
                    ResetPasswordView(
                      email: email,
                      resetToken: state.resetToken ?? '',
                    ),
                  ),
                );
              } else if (state.flowType == OtpFlowType.signup) {
                CustomSnackBar.show(context, state.message);
                unawaited(
                  navigateWithTransition<void>(
                    context,
                    const AuthView(),
                    type: TransitionType.fade,
                    replace: true,
                  ),
                );
              }
            } else if (state.status == OtpStatus.error) {
              CustomSnackBar.show(context, state.message);
            }
          },
          builder: (context, state) {
            final cubit = context.read<OtpCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.otp_verification,
                  style: context.typography.h2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.enter_otp,
                  textAlign: TextAlign.center,
                  style: context.typography.body.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 40.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPTextField(
                    length: 6,
                    width: 1.sw,
                    fieldWidth: 50.w,
                    style: context.typography.titleMedium,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    otpFieldStyle: OtpFieldStyle(),

                    onChanged: cubit.setOtpCode,
                    onCompleted: cubit.setOtpCode,
                  ),
                ),
                SizedBox(height: 40.h),

                CustomButton(
                  isLoading: state.status == OtpStatus.loading,
                  text: Text(context.l10n.verify),
                  onPressed: () => cubit.verifyOtp(email),
                ),
                SizedBox(height: 20.h),
                TextButton(
                  onPressed: state.remainingSeconds == 0
                      ? () => cubit.resendOtp(email)
                      : null,
                  child: Text(
                    state.remainingSeconds == 0
                        ? context.l10n.resend_code
                        : '${context.l10n.resend_after} ${formatTime(state.remainingSeconds)}',
                    style: TextStyle(
                      color: state.remainingSeconds == 0
                          ? context.colors.primary
                          : context.colors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
