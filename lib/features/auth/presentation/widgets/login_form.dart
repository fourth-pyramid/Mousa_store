import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/presentation/bloc/login_bloc.dart';
import 'package:mousa_store/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:mousa_store/features/auth/presentation/pages/otp_page.dart';
import 'package:mousa_store/features/auth/presentation/widgets/sign_with_google.dart';
import 'package:mousa_store/features/wholesale_or_retail/presentation/pages/purchase_type_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ValueNotifier<bool> _obscurePasswordNotifier;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscurePasswordNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: SingleChildScrollView(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 24.w,
        vertical: 16.h,
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  const PurchaseTypeView(),
                  type: TransitionType.fade,
                ),
              );
            },
            emailNotVerified: (message) {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  OtpPage(email: _emailController.text.trim()),
                  type: TransitionType.fade,
                ),
              );
            },
            failure: (error) {
              CustomSnackBar.show(
                context,
                error.isNotEmpty ? error : context.l10n.login_failed_text,
              );
            },
          );
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.l10n.welcome_back_text,
                style: context.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4.h),
              Text(
                'سجل الدخول للمتابعة إلى موسى ستور',
                style: context.typography.caption.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              CustomFormField(
                controller: _emailController,
                hint: context.l10n.email_text,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 20.r,
                  color: context.colors.textSecondary,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.email_validation_error;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              ValueListenableBuilder<bool>(
                valueListenable: _obscurePasswordNotifier,
                builder: (context, obscurePassword, _) => CustomFormField(
                  controller: _passwordController,
                  hint: context.l10n.password_text,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 20.r,
                    color: context.colors.textSecondary,
                  ),
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.r,
                      color: context.colors.textSecondary,
                    ),
                    onPressed: () {
                      _obscurePasswordNotifier.value = !obscurePassword;
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.password_validation_error;
                    }
                    if (value.length < 8) {
                      return context.l10n.password_validation_error;
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 6.h),

              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    unawaited(
                      navigateWithTransition<void>(
                        context,
                        const ForgotPasswordPage(),
                        type: TransitionType.fade,
                      ),
                    );
                  },
                  child: Text(
                    context.l10n.forgot_password_text,
                    style: context.typography.caption.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              CustomButton(
                isLoading: isLoading,
                text: Text(context.l10n.auth_login),
                backgroundColor: context.colors.secondary,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  context.read<LoginBloc>().add(
                    LoginEvent.submitted(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                  );
                },
              ),

              SizedBox(height: 12.h),

              Center(
                child: TextButton.icon(
                  onPressed: () {
                    unawaited(
                      navigateWithTransition<void>(
                        context,
                        const PurchaseTypeView(),
                        replace: true,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 16.r,
                    color: context.colors.textSecondary,
                  ),
                  label: Text(
                    context.l10n.skip_text,
                    style: context.typography.caption.copyWith(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              const SignWithGoogle(),
            ],
          );
        },
      ),
    ),
  );
}
