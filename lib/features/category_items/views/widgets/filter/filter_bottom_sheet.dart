import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/brand.dart';
import 'package:mousa_store/features/category_items/models/product_models.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter/filter_attribute_section.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter/filter_bottom_actions.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter/filter_brand_section.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter/filter_header.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter/filter_price_section.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({required this.cubit, super.key});

  final CategoryItemsCubit cubit;

  static Future<void> show(BuildContext context, CategoryItemsCubit cubit) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => FilterBottomSheet(cubit: cubit),
      );

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late final ValueNotifier<Brand?> _selectedBrandNotifier;
  late final ValueNotifier<RangeValues> _priceRangeNotifier;
  late final ValueNotifier<Map<String, Set<int>>> _selectedAttributesNotifier;

  double get _minPossible => widget.cubit.state.minPrice;
  double get _maxPossible => widget.cubit.state.maxPrice;

  @override
  void initState() {
    super.initState();
    final currentFilter = widget.cubit.state.activeFilter;
    final availableBrands = widget.cubit.state.globalBrands;
    final availableAttributes = widget.cubit.state.globalAttributes;

    Brand? initialBrand;
    if (currentFilter?.brandId != null) {
      for (final b in availableBrands) {
        if (b.id == currentFilter!.brandId) {
          initialBrand = b;
          break;
        }
      }
    }
    _selectedBrandNotifier = ValueNotifier<Brand?>(initialBrand);

    final initialPrice =
        currentFilter?.priceRange ?? RangeValues(_minPossible, _maxPossible);
    _priceRangeNotifier = ValueNotifier<RangeValues>(initialPrice);

    final initialAttrs = <String, Set<int>>{};
    if (currentFilter?.attributeIds != null &&
        currentFilter!.attributeIds!.isNotEmpty) {
      for (final attr in availableAttributes) {
        final matchingIds = attr.values
            .where((v) => currentFilter.attributeIds!.contains(v.id))
            .map((v) => v.id)
            .toSet();
        if (matchingIds.isNotEmpty) {
          initialAttrs[attr.key] = matchingIds;
        }
      }
    }
    _selectedAttributesNotifier = ValueNotifier<Map<String, Set<int>>>(
      initialAttrs,
    );
  }

  @override
  void dispose() {
    _selectedBrandNotifier.dispose();
    _priceRangeNotifier.dispose();
    _selectedAttributesNotifier.dispose();
    super.dispose();
  }

  int _calculateActiveCount({
    required Brand? brand,
    required RangeValues priceRange,
    required Map<String, Set<int>> attributes,
  }) {
    var count = 0;
    if (brand != null) {
      count++;
    }

    final isPriceModified =
        (priceRange.start - _minPossible).abs() > 1 ||
        (priceRange.end - _maxPossible).abs() > 1;
    if (isPriceModified) {
      count++;
    }

    for (final ids in attributes.values) {
      count += ids.length;
    }
    return count;
  }

  void _clearAll() {
    _selectedBrandNotifier.value = null;
    _priceRangeNotifier.value = RangeValues(_minPossible, _maxPossible);
    _selectedAttributesNotifier.value = {};
  }

  void _applyFilter({
    required Brand? brand,
    required RangeValues priceRange,
    required Map<String, Set<int>> attributes,
  }) {
    final flatAttributeIds = <int>[];
    for (final ids in attributes.values) {
      flatAttributeIds.addAll(ids);
    }

    final isPriceModified =
        (priceRange.start - _minPossible).abs() > 1 ||
        (priceRange.end - _maxPossible).abs() > 1;

    final filter = ProductFilter(
      brandId: brand?.id,
      priceRange: isPriceModified ? priceRange : null,
      attributeIds: flatAttributeIds.isNotEmpty ? flatAttributeIds : null,
    );

    widget.cubit.applyFilter(filter);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final availableBrands = widget.cubit.state.globalBrands;
    final availableAttributes = widget.cubit.state.globalAttributes;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
      ),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ValueListenableBuilder<Brand?>(
        valueListenable: _selectedBrandNotifier,
        builder: (context, selectedBrand, _) =>
            ValueListenableBuilder<RangeValues>(
              valueListenable: _priceRangeNotifier,
              builder: (context, priceRange, _) =>
                  ValueListenableBuilder<Map<String, Set<int>>>(
                    valueListenable: _selectedAttributesNotifier,
                    builder: (context, selectedAttributes, _) {
                      final activeCount = _calculateActiveCount(
                        brand: selectedBrand,
                        priceRange: priceRange,
                        attributes: selectedAttributes,
                      );

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Sticky Header
                          FilterHeader(
                            activeFilterCount: activeCount,
                            onClearAll: _clearAll,
                            onClose: () => Navigator.of(context).pop(),
                          ),

                          // Scrollable Filter Sections
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsetsDirectional.only(
                                bottom: 20.h,
                                top: 8.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Brands Section
                                  if (availableBrands.isNotEmpty) ...[
                                    FilterBrandSection(
                                      brands: availableBrands,
                                      selectedBrand: selectedBrand,
                                      onBrandSelected: (brand) =>
                                          _selectedBrandNotifier.value = brand,
                                    ),
                                    SizedBox(height: 16.h),
                                    Divider(
                                      height: 1.h,
                                      indent: 16.w,
                                      endIndent: 16.w,
                                      color: context.colors.divider,
                                    ),
                                    SizedBox(height: 10.h),
                                  ],

                                  // Price Range Section
                                  FilterPriceSection(
                                    priceRange: priceRange,
                                    minPossible: _minPossible,
                                    maxPossible: _maxPossible,
                                    onPriceChanged: (newRange) =>
                                        _priceRangeNotifier.value = newRange,
                                  ),

                                  // Dynamic Attribute Sections
                                  if (availableAttributes.isNotEmpty) ...[
                                    SizedBox(height: 16.h),
                                    Divider(
                                      height: 1.h,
                                      indent: 16.w,
                                      endIndent: 16.w,
                                      color: context.colors.divider,
                                    ),
                                    SizedBox(height: 10.h),
                                  ],

                                  ...availableAttributes.map((attr) {
                                    final currentSelected =
                                        selectedAttributes[attr.key] ?? {};

                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 14.h),
                                      child: FilterAttributeSection(
                                        title: attr.key,
                                        values: attr.values,
                                        selectedIds: currentSelected,
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
                                          _selectedAttributesNotifier.value =
                                              newMap;
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),

                          // Sticky Bottom Action Bar
                          FilterBottomActions(
                            activeFilterCount: activeCount,
                            onApply: () => _applyFilter(
                              brand: selectedBrand,
                              priceRange: priceRange,
                              attributes: selectedAttributes,
                            ),
                            onReset: _clearAll,
                          ),
                        ],
                      );
                    },
                  ),
            ),
      ),
    );
  }
}
