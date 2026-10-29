import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_bloc.dart';
import 'package:mousa_store/features/category_items/presentation/widgets/filter/filter_bottom_sheet.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CategoryItemsBloc, CategoryItemsState>(
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
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      final bloc = context.read<CategoryItemsBloc>();
                      unawaited(FilterBottomSheet.show(context, bloc));
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImage.asset(
                            'assets/icons/filter.png',
                            width: 20,
                            height: 20,
                            color: hasFilter
                                ? context.colors.primary
                                : context.colors.textPrimary,
                          ),
                          const SizedBox(width: 6),
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
                            const SizedBox(width: 6),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: context.radius.pillBorder,
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                child: Text(
                                  '$activeCount',
                                  style: context.typography.caption.copyWith(
                                    color: context.colors.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
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
                    top: -4,
                    end: 0,
                    child: IconButton(
                      onPressed: () =>
                          context.read<CategoryItemsBloc>().resetFilter(),
                      icon: Icon(
                        Icons.close,
                        color: context.colors.error,
                        size: 18,
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
