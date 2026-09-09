import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/setting_profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:mousa_store/features/setting_profile/widget/change_address.dart';
import 'package:mousa_store/features/setting_profile/widget/change_name.dart';
import 'package:mousa_store/features/setting_profile/widget/change_password.dart';
import 'package:mousa_store/features/setting_profile/widget/change_phone_number.dart';
import 'package:mousa_store/features/setting_profile/widget/setting_item.dart';

class SettingProfileView extends StatelessWidget {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = getIt<ProfileCubit>();
      unawaited(cubit.getProfile());
      return cubit;
    },
    child: const _SettingProfileViewBody(),
  );
}

class _SettingProfileViewBody extends StatefulWidget {
  const _SettingProfileViewBody();

  @override
  State<_SettingProfileViewBody> createState() =>
      _SettingProfileViewBodyState();
}

class _SettingProfileViewBodyState extends State<_SettingProfileViewBody> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.edit_profile_text.toUpperCase())),
    body: InternetStateManager(
      onRestoreInternetConnection: () =>
          context.read<ProfileCubit>().getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            CustomSnackBar.show(context, state.message);
          } else if (state is ProfileError) {
            CustomSnackBar.show(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CustomLoadingIndicator());
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingItem(
                    title: context.l10n.chang_text,
                    subtitle: context.l10n.change_name_text,
                    icon: Icons.person_outline_rounded,
                    onTap: () {
                      if (state is ProfileLoaded) {
                        unawaited(
                          navigateWithTransition<void>(
                            context,
                            ChangeName(
                              firstName: state.user.firstName,
                              lastName: state.user.lastName,
                            ),
                            type: TransitionType.fade,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 12.h),
                  SettingItem(
                    title: context.l10n.change_phone_number_text,
                    subtitle: context.l10n.change_phone_persnol_text,
                    icon: Icons.phone_outlined,
                    onTap: () {
                      unawaited(
                        navigateWithTransition<void>(
                          context,
                          const ChangePhoneNumber(),
                          type: TransitionType.fade,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  SettingItem(
                    title: context.l10n.change_password_text,
                    subtitle: context.l10n.change_your_password_text,
                    icon: Icons.lock_outline_rounded,
                    onTap: () {
                      unawaited(
                        navigateWithTransition<void>(
                          context,
                          const ChangePasswordSetting(),
                          type: TransitionType.fade,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  SettingItem(
                    title: context.l10n.addresses_text,
                    subtitle: context.l10n.edit_address_text,
                    icon: Icons.location_on_outlined,
                    onTap: () {
                      unawaited(
                        navigateWithTransition<void>(
                          context,
                          const ChangeAddress(),
                          type: TransitionType.fade,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
