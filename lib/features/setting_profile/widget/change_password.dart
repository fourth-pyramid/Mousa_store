import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/setting_profile/view_model/profile_cubit/profile_cubit.dart';

class ChangePasswordSetting extends StatefulWidget {
  const ChangePasswordSetting({super.key});

  @override
  State<ChangePasswordSetting> createState() => _ChangePasswordSettingState();
}

class _ChangePasswordSettingState extends State<ChangePasswordSetting> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final ValueNotifier<bool> _obscureOldNotifier;
  late final ValueNotifier<bool> _obscureNewNotifier;
  late final ValueNotifier<bool> _obscureConfirmNotifier;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _obscureOldNotifier = ValueNotifier<bool>(true);
    _obscureNewNotifier = ValueNotifier<bool>(true);
    _obscureConfirmNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _obscureOldNotifier.dispose();
    _obscureNewNotifier.dispose();
    _obscureConfirmNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<ProfileCubit>(),
    child: BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          CustomSnackBar.show(
            context,
            context.l10n.password_changed_success_text,
          );
          Navigator.pop(context);
        } else if (state is ProfileError) {
          CustomSnackBar.show(
            context,
            context.l10n.current_password_incorrect_text,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ProfileUpdating;

        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.edit_password_text)),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                children: [
                  Column(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _obscureOldNotifier,
                        builder: (context, obscureOld, _) => CustomFormField(
                          controller: _oldPasswordController,
                          hint: context.l10n.password_old_text,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureOld
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: context.colors.textSecondary,
                            ),
                            onPressed: () {
                              _obscureOldNotifier.value =
                                  !_obscureOldNotifier.value;
                            },
                          ),
                          obscureText: obscureOld,
                        ),
                      ),

                      SizedBox(height: 16.h),

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
                              _obscureNewNotifier.value =
                                  !_obscureNewNotifier.value;
                            },
                          ),
                          obscureText: obscureNew,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.l10n.password_new_text;
                            }
                            if (value.length < 8) {
                              return context.l10n.password_min_8_chars_text;
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
                                      !_obscureConfirmNotifier.value;
                                },
                              ),
                              obscureText: obscureConfirm,
                              validator: (value) {
                                if (value != _newPasswordController.text) {
                                  return context
                                      .l10n
                                      .passwords_do_not_match_text;
                                }
                                return null;
                              },
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
              child: CustomButton(
                isLoading: isLoading,
                text: Text(context.l10n.save_text),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    unawaited(
                      context.read<ProfileCubit>().changePassword(
                        oldPassword: _oldPasswordController.text,
                        password: _newPasswordController.text,
                        confirmPassword: _confirmPasswordController.text,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    ),
  );
}
