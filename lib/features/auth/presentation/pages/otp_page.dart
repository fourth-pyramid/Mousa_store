import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_otp_field.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:mousa_store/features/auth/presentation/pages/auth_page.dart';
import 'package:mousa_store/features/auth/presentation/pages/reset_password_page.dart';

typedef OtpView = OtpPage;

class OtpPage extends StatelessWidget {
  const OtpPage({
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
    create: (_) =>
        getIt<OtpBloc>(param1: flowType)..add(const OtpEvent.started()),
    child: Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: BlocConsumer<OtpBloc, OtpState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == OtpStatus.success) {
              if (state.flowType == OtpFlowType.forgotPassword) {
                unawaited(
                  navigateWithTransition<void>(
                    type: TransitionType.fade,
                    context,
                    ResetPasswordPage(
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
                    const AuthPage(),
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
            final bloc = context.read<OtpBloc>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.otp_verification,
                  style: context.typography.h2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.enter_otp,
                  textAlign: TextAlign.center,
                  style: context.typography.body.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),
                AppOtpField(
                  style: context.typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (code) => bloc.add(OtpEvent.codeChanged(code)),
                  onCompleted: (code) => bloc.add(OtpEvent.codeChanged(code)),
                ),
                const SizedBox(height: 40),

                CustomButton(
                  isLoading: state.status == OtpStatus.loading,
                  text: Text(context.l10n.verify),
                  onPressed: () =>
                      bloc.add(OtpEvent.verifySubmitted(email: email)),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: state.remainingSeconds == 0
                      ? () => bloc.add(OtpEvent.resendSubmitted(email: email))
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
