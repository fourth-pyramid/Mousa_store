import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/layout/layout_view.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';

class PurchaseTypeView extends StatefulWidget {
  const PurchaseTypeView({super.key});

  @override
  State<PurchaseTypeView> createState() => _PurchaseTypeViewState();
}

class _PurchaseTypeViewState extends State<PurchaseTypeView> {
  final ValueNotifier<String?> _selectedTypeNotifier = ValueNotifier<String?>(
    null,
  );

  @override
  void dispose() {
    _selectedTypeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocBuilder<PriceModeCubit, PriceModeState>(
          builder: (context, state) => ValueListenableBuilder<String?>(
            valueListenable: _selectedTypeNotifier,
            builder: (context, selectedTypeRaw, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImage.asset(
                  'assets/images/mousa_store.png',
                  height: 180.h,
                  width: 180.w,
                  color: context.colors.textPrimary == Colors.white
                      ? Colors.white
                      : null,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 14.h),
                Text(
                  context.l10n.choose_your_type_of_shopping.toUpperCase(),
                  style: context.typography.h1.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  context.l10n.do_you_want_to_buy_wholesale_or_retail,
                  textAlign: TextAlign.center,
                  style: context.typography.body.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 28.h),
                AppButton(
                  onPressed: () => _selectedTypeNotifier.value = 'wholesale',
                  text: context.l10n.wholesale_text,
                  variant: selectedTypeRaw == 'wholesale'
                      ? AppButtonVariant.primary
                      : AppButtonVariant.outline,
                ),
                SizedBox(height: 10.h),
                AppButton(
                  onPressed: () => _selectedTypeNotifier.value = 'retail',
                  text: context.l10n.retail_text,
                  variant: selectedTypeRaw == 'retail'
                      ? AppButtonVariant.primary
                      : AppButtonVariant.outline,
                ),
                SizedBox(height: 32.h),
                AppButton(
                  onPressed: selectedTypeRaw != null
                      ? () {
                          final mode = selectedTypeRaw == 'wholesale'
                              ? PriceMode.wholesale
                              : PriceMode.retail;
                          context.read<PriceModeCubit>().setPriceMode(mode);
                          unawaited(
                            navigateWithTransition<void>(
                              context,
                              const LayoutView(),
                              replace: true,
                            ),
                          );
                        }
                      : null,
                  text: context.l10n.continue_text,
                  variant: AppButtonVariant.accent,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
