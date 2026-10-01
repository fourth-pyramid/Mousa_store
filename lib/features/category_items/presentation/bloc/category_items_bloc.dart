import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/domain/entities/product_filter.dart';
import 'package:mousa_store/features/category_items/domain/usecases/get_category_items_use_case.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_event.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_state.dart';

export 'category_items_event.dart';
export 'category_items_state.dart';

class CategoryItemsBloc extends Bloc<CategoryItemsEvent, CategoryItemsState> {
  CategoryItemsBloc({
    required this.getCategoryItemsUseCase,
    required this.getGlobalAttributesUseCase,
    required this.fetchType,
    this.categoryId,
    this.brandId,
  }) : super(const CategoryItemsState()) {
    on<CategoryItemsFetchRequested>(_onFetchRequested);
    on<CategoryItemsLoadMoreRequested>(_onLoadMoreRequested);
    on<CategoryItemsFilterApplied>(_onFilterApplied);
    on<CategoryItemsSortApplied>(_onSortApplied);
    on<CategoryItemsFilterReset>(_onFilterReset);
  }

  final GetCategoryItemsUseCase getCategoryItemsUseCase;
  final GetGlobalAttributesUseCase getGlobalAttributesUseCase;
  final ItemFetchType fetchType;
  final int? categoryId;
  final int? brandId;
  final int perPage = 20;

  // Convenience methods for UI / filter bottom sheet
  void applyFilter(ProductFilter filter) {
    add(CategoryItemsFilterApplied(filter));
  }

  void applySort(ProductSort sort) {
    add(CategoryItemsSortApplied(sort));
  }

  void resetFilter() {
    add(const CategoryItemsFilterReset());
  }

  Future<void> fetchItems() async {
    add(
      CategoryItemsFetchRequested(
        fetchType: fetchType,
        categoryId: categoryId,
        brandId: brandId,
      ),
    );
  }

  Future<void> loadMoreItems() async {
    add(const CategoryItemsLoadMoreRequested());
  }

  Future<void> _onFetchRequested(
    CategoryItemsFetchRequested event,
    Emitter<CategoryItemsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CategoryItemsStatus.loading,
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    try {
      final response = await getCategoryItemsUseCase(
        fetchType: event.fetchType,
        categoryId: event.categoryId,
        perPage: perPage,
        brandId: event.fetchType == ItemFetchType.brand
            ? (event.brandId ?? state.activeFilter?.brandId)
            : state.activeFilter?.brandId,
        attributeIds: state.activeFilter?.attributeIds,
        minPrice: state.activeFilter?.priceRange?.start,
        maxPrice: state.activeFilter?.priceRange?.end,
        sort: _getSortString(state.activeSort),
      );

      final products = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? 1;
      final lastPage = response.data?.lastPage ?? 1;

      final extraction = _extractAttributes(products);

      var globalAttrs = state.globalAttributes;
      var globalBrnds = state.globalBrands;
      var minPrice = extraction.minPrice;
      var maxPrice = extraction.maxPrice;

      if (globalAttrs.isEmpty) {
        try {
          final attrResponse = await getGlobalAttributesUseCase();
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
    }
  }

  Future<void> _onLoadMoreRequested(
    CategoryItemsLoadMoreRequested event,
    Emitter<CategoryItemsState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;

      final response = await getCategoryItemsUseCase(
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
    }
  }

  void _onFilterApplied(
    CategoryItemsFilterApplied event,
    Emitter<CategoryItemsState> emit,
  ) {
    emit(state.copyWith(activeFilter: event.filter));
    add(
      CategoryItemsFetchRequested(
        fetchType: fetchType,
        categoryId: categoryId,
        brandId: brandId,
      ),
    );
  }

  void _onSortApplied(
    CategoryItemsSortApplied event,
    Emitter<CategoryItemsState> emit,
  ) {
    emit(state.copyWith(activeSort: event.sort));
    add(
      CategoryItemsFetchRequested(
        fetchType: fetchType,
        categoryId: categoryId,
        brandId: brandId,
      ),
    );
  }

  void _onFilterReset(
    CategoryItemsFilterReset event,
    Emitter<CategoryItemsState> emit,
  ) {
    emit(state.copyWith(activeFilter: null));
    add(
      CategoryItemsFetchRequested(
        fetchType: fetchType,
        categoryId: categoryId,
        brandId: brandId,
      ),
    );
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

  List<String> _extractBrands(List<CategoryProduct> products) =>
      products.map((p) => p.brand?.name).whereType<String>().toSet().toList()
        ..sort();

  ({Map<String, List<String>> attributes, double minPrice, double maxPrice})
  _extractAttributes(List<CategoryProduct> products) {
    final attributesMap = <String, Set<String>>{};
    var minPrice = double.infinity;
    var maxPrice = -double.infinity;

    for (final product in products) {
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
