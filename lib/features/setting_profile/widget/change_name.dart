import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/setting_profile/service/profile_service.dart';
import 'package:mousa_store/features/setting_profile/view_model/profile_cubit/profile_cubit.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key, this.firstName, this.lastName});
  final String? firstName;
  final String? lastName;

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  final _formKey = GlobalKey<FormState>(); // Declare GlobalKey for Form

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => ProfileCubit(ProfileService()),
    child: BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          CustomSnackBar.show(
            context,
            context.l10n.name_updated_successfully_text,
          );
          Navigator.pop(context);
        } else if (state is ProfileError) {
          CustomSnackBar.show(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is ProfileUpdating;

        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.change_name_text)),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      CustomFormField(
                        controller: _firstNameController,
                        hint: context.l10n.first_name_text,
                        validator: (value) {
                          if (value != null &&
                              value.trim().isEmpty &&
                              _lastNameController.text.trim().isEmpty) {
                            return '${context.l10n.first_name_text} ${context.l10n.required_text}';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomFormField(
                        controller: _lastNameController,
                        hint: context.l10n.last_name_text,
                        validator: (value) {
                          if (value != null &&
                              value.trim().isEmpty &&
                              _firstNameController.text.trim().isEmpty) {
                            return '${context.l10n.last_name_text} ${context.l10n.required_text}';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 8.h,
              ),
              child: CustomButton(
                isLoading: isLoading,
                text: Text(context.l10n.save_text),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newFirstName = _firstNameController.text.trim();
                    final newLastName = _lastNameController.text.trim();

                    final firstNameToSend = newFirstName.isEmpty
                        ? widget.firstName ?? ''
                        : newFirstName;

                    final lastNameToSend = newLastName.isEmpty
                        ? widget.lastName ?? ''
                        : newLastName;

                    if (firstNameToSend == widget.firstName &&
                        lastNameToSend == widget.lastName) {
                      CustomSnackBar.show(
                        context,
                        context.l10n.data_not_updated_text,
                      );
                      return;
                    }

                    unawaited(
                      context.read<ProfileCubit>().updateName(
                        firstName: firstNameToSend,
                        lastName: lastNameToSend,
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
