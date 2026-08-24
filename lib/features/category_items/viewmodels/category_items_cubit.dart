import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/models/product_models.dart';
import 'package:mousa_store/features/category_items/repositories/category_items_repo.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';

class CategoryItemsCubit extends SafeCubit<CategoryItemsState> {
  CategoryItemsCubit({
    required this.repository,
    required this.fetchType,
    this.categoryId,
    this.brandId,
  }) : super(const CategoryItemsState());

  final CategoryItemsRepo repository;
  final ItemFetchType fetchType;
  final int? categoryId;
  final int? brandId;
  final int perPage = 20;

  void refreshData() => fetchItems();

  Future<void> fetchItems() async {
    emit(
      state.copyWith(
        status: CategoryItemsStatus.loading,
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    try {
      // Fetch products
      final response = await repository.getItems(
        fetchType: fetchType,
        categoryId: categoryId,
        perPage: perPage,
        brandId: fetchType == ItemFetchType.brand
            ? (brandId ?? state.activeFilter?.brandId)
            : state.activeFilter?.brandId,
        attributeIds: state.activeFilter?.attributeIds,
        minPrice: state.activeFilter?.priceRange?.start,
        maxPrice: state.activeFilter?.priceRange?.end,
        sort: _getSortString(state.activeSort),
      );

      final products = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? 1;
      final lastPage = response.data?.lastPage ?? 1;

      // Extract attributes from products (for price range and fallback)
      final extraction = _extractAttributes(products);

      // Fetch global attributes and brands only once if empty
      var globalAttrs = state.globalAttributes;
      var globalBrnds = state.globalBrands;
      var minPrice = extraction.minPrice;
      var maxPrice = extraction.maxPrice;

      if (globalAttrs.isEmpty) {
        try {
          final attrResponse = await repository.getGlobalAttributes();
          globalAttrs = attrResponse.data.attributes;
          globalBrnds = attrResponse.data.brands;
          minPrice =
              double.tryParse(attrResponse.data.minPrice) ??
              extraction.minPrice;
          maxPrice =
              double.tryParse(attrResponse.data.maxPrice) ??
                extraction.maxPrice;
        } on Object catch (e) {
          debugPrint('Error fetching global attributes: $e');
        }
      } else {
        // If already loaded, use existing global prices if available, otherwise fallback to extraction
        minPrice = state.minPrice != 0 ? state.minPrice : extraction.minPrice;
        maxPrice = state.maxPrice != 100000
            ? state.maxPrice
            : extraction.maxPrice;
      }

      emit(
        state.copyWith(
          status: CategoryItemsStatus.success,
          products: products,
          currentPage: currentPage,
          lastPage: lastPage,
          hasReachedMax: currentPage >= lastPage,
          availableBrands: _extractBrands(products),
          availableAttributes: extraction.attributes,
          globalAttributes: globalAttrs,
          globalBrands: globalBrnds,
          minPrice: minPrice,
          maxPrice: maxPrice,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: CategoryItemsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      debugPrint(e.toString());
    }
  }

  Future<void> loadMoreItems() async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;

      final response = await repository.getItems(
        fetchType: fetchType,
        categoryId: categoryId,
        page: nextPage,
        perPage: perPage,
        brandId: fetchType == ItemFetchType.brand
            ? (brandId ?? state.activeFilter?.brandId)
            : state.activeFilter?.brandId,
        attributeIds: state.activeFilter?.attributeIds,
        minPrice: state.activeFilter?.priceRange?.start,
        maxPrice: state.activeFilter?.priceRange?.end,
        sort: _getSortString(state.activeSort),
      );

      final newProducts = response.data?.data ?? [];
      final updatedProducts = List<CategoryProduct>.from(state.products)
        ..addAll(newProducts);

      final currentPage = response.data?.currentPage ?? nextPage;
      final lastPage = response.data?.lastPage ?? state.lastPage;

      final extraction = _extractAttributes(updatedProducts);

      emit(
        state.copyWith(
          products: updatedProducts,
          currentPage: currentPage,
          lastPage: lastPage,
          hasReachedMax: currentPage >= lastPage,
          isLoadingMore: false,
          availableBrands: _extractBrands(updatedProducts),
          availableAttributes: extraction.attributes,
          minPrice: extraction.minPrice,
          maxPrice: extraction.maxPrice,
        ),
      );
    } on Object catch (e) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
      debugPrint(e.toString());
    }
  }

  void applyFilter(ProductFilter filter) {
    emit(state.copyWith(activeFilter: () => filter));
    // Refetch items from API with filter
    unawaited(fetchItems());
  }

  void applySort(ProductSort sort) {
    emit(state.copyWith(activeSort: () => sort));
    unawaited(fetchItems());
  }

  String? _getSortString(ProductSort? sort) {
    if (sort == null) return null;
    switch (sort) {
      case ProductSort.nameAZ:
        return 'a_z';
      case ProductSort.nameZA:
        return 'z_a';
      case ProductSort.priceLowHigh:
        return 'low_high';
      case ProductSort.priceHighLow:
        return 'high_low';
      case ProductSort.latest:
        return 'latest';
      default:
        return null;
    }
  }

  void resetFilter() {
    emit(state.copyWith(activeFilter: () => null));
    // Refetch items without filter
    unawaited(fetchItems());
  }

  List<String> _extractBrands(List<CategoryProduct> products) =>
      products.map((p) => p.brand?.name).whereType<String>().toSet().toList()
        ..sort();

  ({Map<String, List<String>> attributes, double minPrice, double maxPrice})
  _extractAttributes(List<CategoryProduct> products) {
    final attributesMap = <String, Set<String>>{};
    var minPrice = double.infinity;
    var maxPrice = -double.infinity;

    for (final product in products) {
      // Calculate price bounds
      final price = double.tryParse(product.displayPrice) ?? 0.0;
      if (price < minPrice) minPrice = price;
      if (price > maxPrice) maxPrice = price;

      if (product.attributes != null) {
        product.attributes!.forEach((key, value) {
          if (value != null) {
            final targetSet = attributesMap.putIfAbsent(key, () => {});
            if (value is List) {
              for (final v in value) {
                targetSet.add(v.toString().trim());
              }
            } else {
              targetSet.add(value.toString().trim());
            }
          }
        });
      }
    }

    // Fallback if no products or infinite values
    if (products.isEmpty || minPrice == double.infinity) {
      minPrice = 0;
      maxPrice = 100000;
    }

    final attributes = attributesMap.map((key, values) {
      final sortedValues = values.toList()..sort();
      return MapEntry(key, sortedValues);
    });

    return (attributes: attributes, minPrice: minPrice, maxPrice: maxPrice);
  }
}
