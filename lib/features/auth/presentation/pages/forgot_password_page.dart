import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/presentation/bloc/forgot_password_bloc.dart';
import 'package:mousa_store/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:mousa_store/features/auth/presentation/pages/otp_page.dart';

typedef ForgetPasswordView = ForgotPasswordPage;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ForgotPasswordBloc>(),
    child: Scaffold(
      appBar: AppBar(title: Text(context.l10n.reset_password_text)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 25.w,
            vertical: 20.h,
          ),
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (response, email) {
                  unawaited(
                    navigateWithTransition<void>(
                      type: TransitionType.fade,
                      context,
                      OtpPage(
                        email: email,
                        flowType: OtpFlowType.forgotPassword,
                      ),
                    ),
                  );
                },
                failure: (message) {
                  CustomSnackBar.show(context, message);
                },
              );
            },
            builder: (context, state) {
              final isLoading = state is ForgotPasswordLoading;

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
                      isLoading: isLoading,
                      text: Text(context.l10n.send_button),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordEvent.submitted(
                              email: _emailController.text.trim(),
                            ),
                          );
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
