// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_bottom_sheet.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/auth/auth_view.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';
import 'package:mousa_store/features/notification/notification_view.dart';
import 'package:mousa_store/features/orders/view/order_view.dart';
import 'package:mousa_store/features/profile/contact_us_view.dart';
import 'package:mousa_store/features/profile/privacy_policy_view.dart';
import 'package:mousa_store/features/profile/widget/language_selection_sheet.dart';
import 'package:mousa_store/features/profile/widget/profile_app_bar.dart';
import 'package:mousa_store/features/profile/widget/purchase_type_selection_sheet.dart';
import 'package:mousa_store/features/profile/widget/theme_selection_sheet.dart';
import 'package:mousa_store/features/setting_profile/setting_profile_view.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, this.goToFavourte});
  final VoidCallback? goToFavourte;

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();
    final isLoggedIn = authService.isLoggedIn;

    return Scaffold(
      appBar: AppBar(title: const ProfileAppbar()),
      body: BlocBuilder<PriceModeCubit, PriceModeState>(
        builder: (context, priceModeState) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              String themeText;
              switch (themeState.themeMode) {
                case ThemeMode.light:
                  themeText = context.l10n.light_mode_text;
                  break;
                case ThemeMode.dark:
                  themeText = context.l10n.dark_mode_text;
                  break;
                case ThemeMode.system:
                  themeText = context.l10n.system_mode_text;
                  break;
              }

              final languageText = languageState.locale.languageCode == 'ar'
                  ? context.l10n.arabic_text
                  : context.l10n.english_text;

              final purchaseTypeText = priceModeState.mode == PriceMode.wholesale
                  ? context.l10n.wholesale_text
                  : context.l10n.retail_text;

              final sections = [
                {
                  'title': context.l10n.account_text,
                  'items': [
                    if (isLoggedIn)
                      {
                        'title': context.l10n.personal_information_text,
                        'subtitle': context.l10n.change_personal_information_text,
                        'icon': Icons.person_outline_rounded,
                        'onTap': () {
                          unawaited(
                            navigateWithTransition<void>(
                              context,
                              const SettingProfileView(),
                              type: TransitionType.fade,
                            ),
                          );
                        },
                      },
                    {
                      'title': context.l10n.favorite_text,
                      'subtitle': context.l10n.favorite_products_text,
                      'icon': Icons.favorite_border_rounded,
                      'onTap': goToFavourte,
                    },
                    if (isLoggedIn)
                      {
                        'title': context.l10n.orders_text,
                        'subtitle': context.l10n.orders_text,
                        'icon': Icons.receipt_long_outlined,
                        'onTap': () {
                          unawaited(
                            navigateWithTransition<void>(context, const OrderView(), type: TransitionType.fade),
                          );
                        },
                      },
                  ],
                },
                {
                  'title': context.l10n.settings_text,
                  'items': [
                    if (isLoggedIn)
                      {
                        'title': context.l10n.notifications_text,
                        'subtitle': context.l10n.notifications_text,
                        'icon': Icons.notifications_none_rounded,
                        'onTap': () {
                          unawaited(
                            navigateWithTransition<void>(context, const NotificationView(), type: TransitionType.fade),
                          );
                        },
                      },
                    {
                      'title': context.l10n.change_language_text,
                      'subtitle': languageText,
                      'icon': Icons.language_rounded,
                      'onTap': () =>
                          unawaited(AppBottomSheet.show<void>(context: context, child: const LanguageSelectionSheet())),
                    },
                    {
                      'title': context.l10n.enable_dark_mode_text,
                      'subtitle': themeText,
                      'icon': Icons.brightness_6_outlined,
                      'onTap': () =>
                          unawaited(AppBottomSheet.show<void>(context: context, child: const ThemeSelectionSheet())),
                    },
                    {
                      'title': context.l10n.choose_your_type_of_shopping,
                      'subtitle': purchaseTypeText,
                      'icon': Icons.storefront_outlined,
                      'onTap': () => unawaited(
                        AppBottomSheet.show<void>(context: context, child: const PurchaseTypeSelectionSheet()),
                      ),
                    },
                  ],
                },
              ];

              if (isLoggedIn) {
                sections.add({
                  'title': context.l10n.privacy_text,
                  'items': [
                    {
                      'title': context.l10n.contact_us_text,
                      'icon': Icons.headset_mic_outlined,
                      'onTap': () {
                        unawaited(
                          navigateWithTransition<void>(context, const ContactUsView(), type: TransitionType.fade),
                        );
                      },
                    },
                    {
                      'title': context.l10n.privacy_policy_text,
                      'icon': Icons.privacy_tip_outlined,
                      'onTap': () {
                        unawaited(
                          navigateWithTransition<void>(context, const PrivacyPolicyView(), type: TransitionType.fade),
                        );
                      },
                    },
                    {
                      'title': context.l10n.logout_text,
                      'icon': Icons.logout_rounded,
                      'color': context.colors.secondary,
                      'onTap': () => _showLogoutDialog(context, authService, context.l10n),
                    },
                  ],
                });
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                itemCount: sections.length,
                separatorBuilder: (_, _) => SizedBox(height: 24.h),
                itemBuilder: (context, sectionIndex) {
                  final section = sections[sectionIndex];
                  final items = section['items']! as List<dynamic>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (section['title']! as String).toUpperCase(),
                        style: context.typography.labelMedium.copyWith(color: context.colors.textSecondary, letterSpacing: 1.0),
                      ),
                      SizedBox(height: 12.h),
                      ...items.map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Material(
                            color: context.colors.surface,
                            borderRadius: context.radius.smBorder,
                            child: ListTile(
                              onTap: item['onTap'] as VoidCallback?,
                              shape: RoundedRectangleBorder(borderRadius: context.radius.smBorder),
                              leading: Icon(item['icon'] as IconData, color: item['color'] as Color? ?? context.colors.textPrimary),
                              title: Text(
                                item['title'] as String,
                                style: context.typography.body.copyWith(
                                  color: item['color'] as Color? ?? context.colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: item['subtitle'] != null
                                  ? Text(
                                      item['subtitle'] as String,
                                      style: context.typography.bodySmall.copyWith(color: context.colors.textSecondary),
                                    )
                                  : null,
                              trailing: Icon(Icons.chevron_right_rounded, color: context.colors.textSecondary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthService authService, AppLocalizations localizations) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(localizations.logout_confirmation_text.toUpperCase()),
          content: Text(localizations.logout_confirmation_message_shure_text),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(localizations.cancel_text)),
            AppButton(
              text: localizations.logout_text,
              variant: AppButtonVariant.accent,
              isFullWidth: false,
              onPressed: () async {
                await authService.logout();
                getIt<FavoriteCubit>().reset();
                if (!context.mounted) return;
                unawaited(
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (_) => const AuthView()),
                    (route) => false,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
