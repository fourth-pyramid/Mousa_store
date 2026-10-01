import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/profile_bloc.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key, this.firstName, this.lastName});
  final String? firstName;
  final String? lastName;

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<ProfileBloc>(),
    child: BlocConsumer<ProfileBloc, ProfileState>(
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomFormField(
                    controller: _firstNameController,
                    hint: context.l10n.first_name_text,
                    label: context.l10n.first_name_text,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.l10n.first_name_validation_error;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    controller: _lastNameController,
                    hint: context.l10n.last_name_text,
                    label: context.l10n.last_name_text,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.l10n.last_name_validation_error;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    text: Text(context.l10n.save_text),
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newFirstName = _firstNameController.text.trim();
                        final newLastName = _lastNameController.text.trim();

                        final firstNameToSend =
                            newFirstName != widget.firstName
                                ? newFirstName
                                : null;
                        final lastNameToSend =
                            newLastName != widget.lastName
                                ? newLastName
                                : null;

                        if (firstNameToSend == null && lastNameToSend == null) {
                          CustomSnackBar.show(
                            context,
                            context.l10n.data_not_updated_text,
                          );
                          return;
                        }

                        context.read<ProfileBloc>().add(
                              ProfileEvent.nameUpdated(
                                firstName: firstNameToSend,
                                lastName: lastNameToSend,
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
