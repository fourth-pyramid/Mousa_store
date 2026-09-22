import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter/filter_bottom_sheet.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CategoryItemsCubit, CategoryItemsState>(
        builder: (context, state) {
          final hasFilter =
              state.activeFilter != null && !state.activeFilter!.isEmpty;

          // Calculate active items count on trigger button badge
          var activeCount = 0;
          if (state.activeFilter?.brandId != null) activeCount++;
          if (state.activeFilter?.priceRange != null) activeCount++;
          if (state.activeFilter?.attributeIds != null) {
            activeCount += state.activeFilter!.attributeIds!.length;
          }

          return Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  color: hasFilter
                      ? context.colors.primary.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      final cubit = context.read<CategoryItemsCubit>();
                      unawaited(FilterBottomSheet.show(context, cubit));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 10.h,
                        horizontal: 8.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImage.asset(
                            'assets/icons/filter.png',
                            width: 20.w,
                            height: 20.h,
                            color: hasFilter
                                ? context.colors.primary
                                : context.colors.textPrimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            context.l10n.filter_text,
                            style: context.typography.titleMedium.copyWith(
                              color: hasFilter
                                  ? context.colors.primary
                                  : context.colors.textPrimary,
                              fontWeight: hasFilter
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                          if (hasFilter && activeCount > 0) ...[
                            SizedBox(width: 6.w),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: context.radius.pillBorder,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  '$activeCount',
                                  style: context.typography.caption.copyWith(
                                    color: context.colors.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                if (hasFilter)
                  PositionedDirectional(
                    top: -4.h,
                    end: 0,
                    child: IconButton(
                      onPressed: () =>
                          context.read<CategoryItemsCubit>().resetFilter(),
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
