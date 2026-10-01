import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/category_items/data/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/brand.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/domain/entities/product_filter.dart';

part 'category_items_state.freezed.dart';

enum CategoryItemsStatus { initial, loading, success, failure }

@freezed
abstract class CategoryItemsState with _$CategoryItemsState {
  const factory CategoryItemsState({
    @Default(CategoryItemsStatus.initial) CategoryItemsStatus status,
    @Default([]) List<CategoryProduct> products,
    @Default([]) List<String> availableBrands,
    @Default({}) Map<String, List<String>> availableAttributes,
    @Default([]) List<AttributeData> globalAttributes,
    @Default([]) List<Brand> globalBrands,
    @Default(0) double minPrice,
    @Default(100000) double maxPrice,
    ProductFilter? activeFilter,
    @Default(ProductSort.nameAZ) ProductSort? activeSort,
    String? errorMessage,
    @Default(1) int currentPage,
    @Default(1) int lastPage,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
  }) = _CategoryItemsState;
}
