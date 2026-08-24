import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_state.dart';
import 'package:mousa_store/features/auth/widgets/forget_password/otp_view.dart';
import 'package:mousa_store/features/auth/widgets/sign_with_google.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureConfirmPasswordNotifier = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _obscurePasswordNotifier.dispose();
    _obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<SignupCubit, SignupState>(
    listener: (context, state) {
      if (state.status == SignupStatus.success) {
        CustomSnackBar.show(context, state.response?.message ?? context.l10n.success_text);
        unawaited(
          navigateWithTransition<void>(
            type: TransitionType.fade,
            context,
            OtpView(email: _emailController.text.trim()),
          ),
        );
      } else if (state.status == SignupStatus.failure) {
        CustomSnackBar.show(context, state.errorMessage ?? context.l10n.error_text);
      }
    },
    builder: (context, state) {
      final isLoading = state.status == SignupStatus.loading;

      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.l10n.welcome_start_text,
                style: context.typography.h2.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4.h),
              Text(
                'أنشئ حسابك الجديد للبدء بالتسوق في موسى ستور',
                style: context.typography.caption.copyWith(color: context.colors.textSecondary),
              ),
              SizedBox(height: 20.h),
              CustomFormField(
                controller: _firstNameController,
                hint: context.l10n.first_name_text,
                prefixIcon: Icon(Icons.person_outline, size: 20.r, color: context.colors.textSecondary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.first_name_validation_error;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: _lastNameController,
                hint: context.l10n.last_name_text,
                prefixIcon: Icon(Icons.person_outline, size: 20.r, color: context.colors.textSecondary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.last_name_validation_error;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: _emailController,
                hint: context.l10n.email_text,
                prefixIcon: Icon(Icons.email_outlined, size: 20.r, color: context.colors.textSecondary),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.email_validation_error;
                  }
                  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)) {
                    return context.l10n.email_validation_error;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: _phoneController,
                hint: context.l10n.phone_number_text,
                prefixIcon: Icon(Icons.phone_outlined, size: 20.r, color: context.colors.textSecondary),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l10n.phone_number_validation_error;
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
                  prefixIcon: Icon(Icons.lock_outline, size: 20.r, color: context.colors.textSecondary),
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20.r,
                      color: context.colors.textSecondary,
                    ),
                    onPressed: () {
                      _obscurePasswordNotifier.value = !_obscurePasswordNotifier.value;
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
              SizedBox(height: 16.h),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureConfirmPasswordNotifier,
                builder: (context, obscureConfirmPassword, _) => CustomFormField(
                  controller: _confirmPasswordController,
                  hint: context.l10n.confirm_password_text,
                  prefixIcon: Icon(Icons.lock_outline, size: 20.r, color: context.colors.textSecondary),
                  obscureText: obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20.r,
                      color: context.colors.textSecondary,
                    ),
                    onPressed: () {
                      _obscureConfirmPasswordNotifier.value = !_obscureConfirmPasswordNotifier.value;
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.confirm_password_validation_error;
                    }
                    if (value != _passwordController.text) {
                      return context.l10n.confirm_password_validation_error;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 24.h),

              CustomButton(
                isLoading: isLoading,
                text: Text(context.l10n.auth_register),
                backgroundColor: context.colors.secondary,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    unawaited(
                      context.read<SignupCubit>().signup(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                        passwordConfirmation: _confirmPasswordController.text,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 24.h),
              const SignWithGoogle(),
            ],
          ),
        ),
      );
    },
  );
}
