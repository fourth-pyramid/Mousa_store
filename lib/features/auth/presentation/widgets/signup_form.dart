import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:mousa_store/features/auth/presentation/pages/otp_page.dart';
import 'package:mousa_store/features/auth/presentation/widgets/sign_with_google.dart';
import 'package:phone_text_field/phone_text_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final ValueNotifier<bool> _obscurePasswordNotifier;
  late final ValueNotifier<bool> _obscureConfirmPasswordNotifier;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
    _obscurePasswordNotifier = ValueNotifier<bool>(true);
    _obscureConfirmPasswordNotifier = ValueNotifier<bool>(true);
  }

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
  Widget build(BuildContext context) => BlocConsumer<SignupBloc, SignupState>(
    listener: (context, state) {
      state.whenOrNull(
        success: (response) {
          CustomSnackBar.show(
            context,
            response.message.isNotEmpty ? response.message : context.l10n.success_text,
          );
          unawaited(
            navigateWithTransition<void>(
              type: TransitionType.fade,
              context,
              OtpPage(email: _emailController.text.trim()),
            ),
          );
        },
        failure: (errorMessage) {
          CustomSnackBar.show(
            context,
            errorMessage.isNotEmpty ? errorMessage : context.l10n.error_text,
          );
        },
      );
    },
    builder: (context, state) {
      final isLoading = state is SignupLoading;

      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.l10n.welcome_start_text,
                style: context.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4.h),
              Text(
                'أنشئ حسابك واستمتع بتجربة تسوق فريدة',
                style: context.typography.caption.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: _firstNameController,
                      hint: context.l10n.first_name_text,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: 20.r,
                        color: context.colors.textSecondary,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.first_name_validation_error;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomFormField(
                      controller: _lastNameController,
                      hint: context.l10n.last_name_text,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: 20.r,
                        color: context.colors.textSecondary,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.last_name_validation_error;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
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
              PhoneTextField(
                invalidNumberMessage: context.l10n.phone_number_validation_error,
                dialogTitle: '',
                initialCountryCode: 'EG',
                searchTextStyle: context.typography.titleMedium,
                decoration: InputDecoration(
                  labelText: context.l10n.phone_number_text,
                  labelStyle: context.typography.titleMedium,
                ),
                searchFieldInputDecoration: InputDecoration(
                  hintText: context.l10n.search_country_text,
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (phoneNumber) {
                  _phoneController.text = phoneNumber.completeNumber;
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
              SizedBox(height: 16.h),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureConfirmPasswordNotifier,
                builder: (context, obscureConfirmPassword, _) =>
                    CustomFormField(
                      controller: _confirmPasswordController,
                      hint: context.l10n.password_confirm_text,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 20.r,
                        color: context.colors.textSecondary,
                      ),
                      obscureText: obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20.r,
                          color: context.colors.textSecondary,
                        ),
                        onPressed: () {
                          _obscureConfirmPasswordNotifier.value =
                              !obscureConfirmPassword;
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.password_validation_error;
                        }
                        if (value != _passwordController.text) {
                          return context.l10n.passwords_do_not_match_text;
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
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  context.read<SignupBloc>().add(
                    SignupEvent.submitted(
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      email: _emailController.text.trim(),
                      phone: _phoneController.text.trim(),
                      password: _passwordController.text.trim(),
                      passwordConfirmation:
                          _confirmPasswordController.text.trim(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              const SignWithGoogle(),
            ],
          ),
        ),
      );
    },
  );
}
