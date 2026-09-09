import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_bottom_sheet.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/category_items/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/brand.dart';
import 'package:mousa_store/features/category_items/models/product_models.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';

class _AttributeSection extends StatelessWidget {
  const _AttributeSection({
    required this.title,
    required this.values,
    required this.selectedIds,
    required this.onChanged,
  });

  final String title;
  final List<AttributeValue> values;
  final Set<int> selectedIds;
  final ValueChanged<Set<int>> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Text(title, style: context.typography.titleLarge),
            if (selectedIds.isNotEmpty) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: context.radius.smBorder,
                ),
                child: Text(
                  '${selectedIds.length}',
                  style: context.typography.caption.copyWith(
                    color: context.colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: values
                .map(
                  (attrValue) => Padding(
                    padding: EdgeInsetsDirectional.only(end: 8.w),
                    child: _buildChip(context, attrValue),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    ],
  );

  Widget _buildChip(BuildContext context, AttributeValue attrValue) {
    final isSelected = selectedIds.contains(attrValue.id);

    return GestureDetector(
      onTap: () {
        final newSelection = Set<int>.from(selectedIds);
        if (isSelected) {
          newSelection.remove(attrValue.id);
        } else {
          newSelection.add(attrValue.id);
        }
        onChanged(newSelection);
      },
      child: AnimatedContainer(
        duration: context.durations.fast,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.transparent,
          borderRadius: context.radius.xsBorder,
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Icon(Icons.check, size: 16.r, color: context.colors.onPrimary),
              SizedBox(width: 4.w),
            ],
            Text(
              attrValue.value,
              style: context.typography.body.copyWith(
                color: isSelected
                    ? context.colors.onPrimary
                    : context.colors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<CategoryItemsCubit, CategoryItemsState>(
    builder: (context, state) {
      final hasFilter =
          state.activeFilter != null && !state.activeFilter!.isEmpty;

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
                        final currentFilter = cubit.state.activeFilter;

                        final availableBrands = cubit.state.globalBrands;
                        final availableAttributes =
                            cubit.state.globalAttributes;

                        final minPossible = cubit.state.minPrice;
                        final maxPossible = cubit.state.maxPrice;

                        final selectedBrandNotifier = ValueNotifier<Brand?>(
                          availableBrands.any(
                                (b) => b.id == currentFilter?.brandId,
                              )
                              ? availableBrands.firstWhere(
                                  (b) => b.id == currentFilter?.brandId,
                                )
                              : null,
                        );
                        final priceRangeNotifier = ValueNotifier<RangeValues>(
                          currentFilter?.priceRange ??
                              RangeValues(minPossible, maxPossible),
                        );

                        final initialSelections = <String, Set<int>>{};
                        if (currentFilter?.attributeIds != null) {
                          for (final attr in availableAttributes) {
                            final matchingIds = attr.values
                                .where(
                                  (v) => currentFilter!.attributeIds!.contains(
                                    v.id,
                                  ),
                                )
                                .map((v) => v.id)
                                .toSet();
                            if (matchingIds.isNotEmpty) {
                              initialSelections[attr.key] = matchingIds;
                            }
                          }
                        }

                        final selectedAttributesNotifier =
                            ValueNotifier<Map<String, Set<int>>>(
                              initialSelections,
                            );

                        return ValueListenableBuilder<Brand?>(
                          valueListenable: selectedBrandNotifier,
                          builder: (context, selectedBrand, _) => ValueListenableBuilder<RangeValues>(
                            valueListenable: priceRangeNotifier,
                            builder: (context, priceRange, _) => ValueListenableBuilder<Map<String, Set<int>>>(
                              valueListenable: selectedAttributesNotifier,
                              builder: (context, selectedAttributes, _) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          context.l10n.filter_text,
                                          style: context.typography.titleLarge
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: Icon(
                                            Icons.close,
                                            size: 24.r,
                                            color: context.colors.textPrimary,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: context.colors.divider,
                                  ),

                                  Flexible(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (availableBrands.isNotEmpty) ...[
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 8.h,
                                                  ),
                                              child: Text(
                                                context.l10n.brand_text,
                                                style: context
                                                    .typography
                                                    .titleLarge,
                                              ),
                                            ),
                                            RadioGroup<Brand?>(
                                              groupValue: selectedBrand,
                                              onChanged: (value) =>
                                                  selectedBrandNotifier.value =
                                                      value,
                                              child: Column(
                                                children: [
                                                  RadioListTile<Brand?>(
                                                    value: null,
                                                    title: Text(
                                                      context
                                                          .l10n
                                                          .all_brands_text,
                                                      style: context
                                                          .typography
                                                          .body,
                                                    ),
                                                  ),
                                                  ...List.generate(
                                                    availableBrands.length,
                                                    (index) {
                                                      final brand =
                                                          availableBrands[index];
                                                      return RadioListTile<
                                                        Brand?
                                                      >(
                                                        value: brand,
                                                        secondary:
                                                            brand.imagePath !=
                                                                null
                                                            ? AppImage(
                                                                image: brand
                                                                    .imagePath!,
                                                                width: 24.w,
                                                                height: 24.h,
                                                                errorWidget:
                                                                    (
                                                                      context,
                                                                      url,
                                                                      error,
                                                                    ) =>
                                                                        const SizedBox(),
                                                              )
                                                            : null,
                                                        title: Text(
                                                          brand.name ?? '',
                                                          style: context
                                                              .typography
                                                              .body,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],

                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 8.h,
                                                ),
                                            child: Text(
                                              context.l10n.prices_text,
                                              style:
                                                  context.typography.titleLarge,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 8.h,
                                                ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                _buildPriceLabel(
                                                  priceRange.start,
                                                  context,
                                                ),
                                                _buildPriceLabel(
                                                  priceRange.end,
                                                  context,
                                                ),
                                              ],
                                            ),
                                          ),
                                          RangeSlider(
                                            values: priceRange,
                                            min: minPossible,
                                            max: maxPossible,
                                            activeColor: context.colors.primary,
                                            inactiveColor: context
                                                .colors
                                                .primary
                                                .withAlpha((0.2 * 255).toInt()),
                                            divisions:
                                                (maxPossible - minPossible) > 0
                                                ? (maxPossible - minPossible)
                                                      .toInt()
                                                      .clamp(1, 100)
                                                : null,
                                            onChanged: (values) =>
                                                priceRangeNotifier.value =
                                                    values,
                                          ),

                                          ...availableAttributes.map((attr) {
                                            final selectedIds =
                                                selectedAttributes[attr.key] ??
                                                {};

                                            return _AttributeSection(
                                              title: attr.key,
                                              values: attr.values,
                                              selectedIds: selectedIds,
                                              onChanged: (newIds) {
                                                final newMap =
                                                    Map<String, Set<int>>.from(
                                                      selectedAttributes,
                                                    );
                                                if (newIds.isEmpty) {
                                                  newMap.remove(attr.key);
                                                } else {
                                                  newMap[attr.key] = newIds;
                                                }
                                                selectedAttributesNotifier
                                                        .value =
                                                    newMap;
                                              },
                                            );
                                          }),

                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 16.h,
                                                ),
                                            child: CustomButton(
                                              text: Text(
                                                context.l10n.apply_text,
                                              ),
                                              onPressed: () {
                                                final flatAttributeIds =
                                                    <int>[];
                                                for (final ids
                                                    in selectedAttributes
                                                        .values) {
                                                  flatAttributeIds.addAll(ids);
                                                }

                                                cubit.applyFilter(
                                                  ProductFilter(
                                                    brandId: selectedBrand?.id,
                                                    priceRange: priceRange,
                                                    attributeIds:
                                                        flatAttributeIds
                                                            .isNotEmpty
                                                        ? flatAttributeIds
                                                        : null,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                      'assets/icons/filter.png',
                      width: 20.w,
                      height: 20.h,
                      color: context.colors.textPrimary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      context.l10n.filter_text,
                      style: context.typography.titleMedium,
                    ),
                  ],
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

  Widget _buildPriceLabel(double value, BuildContext context) => Container(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 6.h),
    decoration: BoxDecoration(
      color: context.colors.primary.withAlpha((0.1 * 255).toInt()),
      borderRadius: context.radius.xsBorder,
      border: Border.all(
        color: context.colors.primary.withAlpha((0.3 * 255).toInt()),
      ),
    ),
    child: Text(
      '${value.toInt()} EGP',
      style: context.typography.body.copyWith(
        color: context.colors.primary,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
