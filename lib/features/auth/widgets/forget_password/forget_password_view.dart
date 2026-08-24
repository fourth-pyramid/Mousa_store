import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:mousa_store/features/auth/view_model/forgot_password_cubit/forgot_password_state.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_state.dart';
import 'package:mousa_store/features/auth/widgets/forget_password/otp_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ForgotPasswordCubit>(),
    child: Scaffold(
      appBar: AppBar(title: Text(context.l10n.reset_password_text)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 25.w,
            vertical: 20.h,
          ),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.status == ForgotPasswordStatus.success) {
                unawaited(
                  navigateWithTransition<void>(
                    type: TransitionType.fade,
                    context,
                    OtpView(
                      email: _emailController.text,
                      flowType: OtpFlowType.forgotPassword,
                    ),
                  ),
                );
              } else if (state.status == ForgotPasswordStatus.failure) {
                CustomSnackBar.show(context, state.message);
              }
            },
            builder: (context, state) {
              final cubit = context.read<ForgotPasswordCubit>();

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      hint: context.l10n.email_text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.email_validation_error;
                        }

                        if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                        ).hasMatch(value)) {
                          return context.l10n.email_validation_error;
                        }

                        return null;
                      },
                    ),
                    const Spacer(),

                    CustomButton(
                      isLoading: state.status == ForgotPasswordStatus.loading,
                      text: Text(context.l10n.send_button),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          unawaited(cubit.sendEmail(_emailController.text));
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
