import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_bottom_sheet.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/category_items/models/product_models.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CategoryItemsCubit, CategoryItemsState>(
        builder: (context, state) {
          final isNotDefaultSort = state.activeSort != ProductSort.nameAZ;

          return Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {
                    final cubit = context.read<CategoryItemsCubit>();
                    unawaited(
                      AppBottomSheet.show<void>(
                        context: context,
                        child: Builder(
                          builder: (context) {
                            final activeSort = cubit.state.activeSort;
                            final selectedOptionNotifier = ValueNotifier<int>(
                              activeSort?.index ?? 1,
                            );
                            final options = <String>[
                              context.l10n.most_popular_text,
                              context.l10n.a_to_z_text,
                              context.l10n.z_to_a_text,
                              context.l10n.low_to_high_text,
                              context.l10n.high_to_low_text,
                              context.l10n.latest_text,
                              context.l10n.featured_discounts_text,
                            ];

                            return ValueListenableBuilder<int>(
                              valueListenable: selectedOptionNotifier,
                              builder: (context, selectedOption, _) => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: Text(
                                      context.l10n.sort_by_text,
                                      style: context.typography.titleLarge,
                                    ),
                                  ),
                                  RadioGroup<int>(
                                    groupValue: selectedOption,
                                    onChanged: (value) =>
                                        selectedOptionNotifier.value = value!,
                                    child: Column(
                                      children: List.generate(
                                        options.length,
                                        (index) => RadioListTile<int>(
                                          value: index,
                                          title: Text(
                                            options[index],
                                            style: context.typography.body,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.h,
                                    ),
                                    child: CustomButton(
                                      text: Text(context.l10n.apply_text),
                                      onPressed: () {
                                        final sort =
                                            ProductSort.values[selectedOption];
                                        cubit.applySort(sort);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage.asset(
                          'assets/icons/sort_vertical.png',
                          width: 20.w,
                          height: 20.h,
                          color: context.colors.textPrimary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          context.l10n.sort_by_text,
                          style: context.typography.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                if (isNotDefaultSort)
                  PositionedDirectional(
                    top: -4.h,
                    end: 0,
                    child: IconButton(
                      onPressed: () => context
                          .read<CategoryItemsCubit>()
                          .applySort(ProductSort.nameAZ),
                      icon: Icon(
                        Icons.close,
                        color: context.colors.error,
                        size: 18.r,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
              ],
            ),
          );
        },
      );
}
