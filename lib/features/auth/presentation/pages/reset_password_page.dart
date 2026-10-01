import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/auth/presentation/bloc/reset_password_bloc.dart';

typedef ResetPasswordView = ResetPasswordPage;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    required this.resetToken,
    required this.email,
    super.key,
  });
  final String email;
  final String resetToken;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
    create: (_) => getIt<ResetPasswordBloc>(),
    child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (response) {
            CustomSnackBar.show(context, response.message);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          failure: (message) {
            CustomSnackBar.show(context, message);
          },
        );
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;

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
                                        !obscureConfirm;
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
                  ),
                ),
                const Spacer(),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 16.w,
                      bottom: 16.h,
                    ),
                    child: CustomButton(
                      isLoading: isLoading,
                      text: Text(context.l10n.save_text),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ResetPasswordBloc>().add(
                            ResetPasswordEvent.submitted(
                              email: widget.email,
                              newPassword: _newPasswordController.text,
                              passwordConfirm: _confirmPasswordController.text,
                              resetToken: widget.resetToken,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
