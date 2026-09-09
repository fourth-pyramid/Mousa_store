import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/setting_profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:phone_text_field/phone_text_field.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = getIt<ProfileCubit>();
      unawaited(cubit.getProfile());
      return cubit;
    },
    child: const _ChangePhoneNumberBody(),
  );
}

class _ChangePhoneNumberBody extends StatefulWidget {
  const _ChangePhoneNumberBody();

  @override
  State<_ChangePhoneNumberBody> createState() => _ChangePhoneNumberBodyState();
}

class _ChangePhoneNumberBodyState extends State<_ChangePhoneNumberBody> {
  late final ValueNotifier<String> _phoneNumberNotifier;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneNumberNotifier = ValueNotifier<String>('');
  }

  @override
  void dispose() {
    _phoneNumberNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            CustomSnackBar.show(
              context,
              context.l10n.phone_number_changed_success_text,
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            CustomSnackBar.show(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfileUpdating;
          return Scaffold(
            appBar: AppBar(title: Text(context.l10n.edit_phone_text)),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PhoneTextField(
                          invalidNumberMessage:
                              context.l10n.phone_number_validation_error,
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
                            _phoneNumberNotifier.value =
                                phoneNumber.completeNumber;
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
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
                child: CustomButton(
                  isLoading: isLoading,
                  text: Text(context.l10n.save_text),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final cubit = context.read<ProfileCubit>();
                      final currentUser = CacheHelper.getUser();

                      if (currentUser != null) {
                        unawaited(
                          cubit.updatePhone(phone: _phoneNumberNotifier.value),
                        );
                      } else {
                        CustomSnackBar.show(
                          context,
                          context.l10n.error_occurred_text,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
      );
}
