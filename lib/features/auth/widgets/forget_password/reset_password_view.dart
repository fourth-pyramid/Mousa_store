import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/view_model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mousa_store/features/auth/view_model/reset_password_cubit/reset_password_state.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({
    required this.resetToken,
    required this.email,
    super.key,
  });
  final String email;
  final String resetToken;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ValueNotifier<bool> _obscureNewNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureConfirmNotifier = ValueNotifier<bool>(true);
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _obscureNewNotifier.dispose();
    _obscureConfirmNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ResetPasswordCubit>(),
    child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == ResetPasswordStatus.success) {
          CustomSnackBar.show(context, state.message);
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state.status == ResetPasswordStatus.failure) {
          CustomSnackBar.show(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ResetPasswordCubit>();

        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.edit_password_text)),
          body: SafeArea(
            child: Column(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: _obscureNewNotifier,
                          builder: (context, obscureNew, _) => CustomFormField(
                            controller: _newPasswordController,
                            hint: context.l10n.password_new_text,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureNew
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: context.colors.textSecondary,
                              ),
                              onPressed: () {
                                _obscureNewNotifier.value = !obscureNew;
                              },
                            ),
                            obscureText: obscureNew,
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
                          valueListenable: _obscureConfirmNotifier,
                          builder: (context, obscureConfirm, _) =>
                              CustomFormField(
                                controller: _confirmPasswordController,
                                hint: context.l10n.password_confirm_text,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureConfirm
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: context.colors.textSecondary,
                                  ),
                                  onPressed: () {
                                    _obscureConfirmNotifier.value =
                                        !obscureConfirm;
                                  },
                                ),
                                obscureText: obscureConfirm,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context
                                        .l10n
                                        .password_validation_error;
                                  }
                                  if (value != _newPasswordController.text) {
                                    return context
                                        .l10n
                                        .confirm_password_validation_error;
                                  }
                                  return null;
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            child: CustomButton(
              isLoading: state.status == ResetPasswordStatus.loading,
              text: Text(context.l10n.save_text),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  unawaited(
                    cubit.resetPassword(
                      email: widget.email,
                      newPassword: _newPasswordController.text,
                      confirmPassword: _confirmPasswordController.text,
                      resetToken: widget.resetToken,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    ),
  );
}
