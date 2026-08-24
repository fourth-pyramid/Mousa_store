import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mousa_store/features/category_items/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/brand.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/models/product_models.dart';

enum CategoryItemsStatus { initial, loading, success, failure }

@immutable
class CategoryItemsState extends Equatable {
  const CategoryItemsState({
    this.status = CategoryItemsStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.lastPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.activeFilter,
    this.activeSort = ProductSort.nameAZ,
    this.availableBrands = const [],
    this.availableAttributes = const {},
    this.globalAttributes = const [],
    this.globalBrands = const [],
    this.minPrice = 0,
    this.maxPrice = 100000,
  });

  final CategoryItemsStatus status;
  final List<CategoryProduct> products;
  final List<String> availableBrands;
  final Map<String, List<String>> availableAttributes;
  final List<AttributeData> globalAttributes;
  final List<Brand> globalBrands;
  final double minPrice;
  final double maxPrice;
  final ProductFilter? activeFilter;
  final ProductSort? activeSort;
  final String? errorMessage;
  final int currentPage;
  final int lastPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  CategoryItemsState copyWith({
    CategoryItemsStatus? status,
    List<CategoryProduct>? products,
    String? errorMessage,
    int? currentPage,
    int? lastPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    List<String>? availableBrands,
    Map<String, List<String>>? availableAttributes,
    List<AttributeData>? globalAttributes,
    List<Brand>? globalBrands,
    ValueGetter<ProductFilter?>? activeFilter,
    ValueGetter<ProductSort?>? activeSort,
    double? minPrice,
    double? maxPrice,
  }) => CategoryItemsState(
    status: status ?? this.status,
    products: products ?? this.products,
    availableBrands: availableBrands ?? this.availableBrands,
    availableAttributes: availableAttributes ?? this.availableAttributes,
    globalAttributes: globalAttributes ?? this.globalAttributes,
    globalBrands: globalBrands ?? this.globalBrands,
    minPrice: minPrice ?? this.minPrice,
    maxPrice: maxPrice ?? this.maxPrice,
    activeFilter: activeFilter != null ? activeFilter() : this.activeFilter,
    activeSort: activeSort != null ? activeSort() : this.activeSort,
    errorMessage: errorMessage ?? this.errorMessage,
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );

  @override
  List<Object?> get props => [
    status,
    products,
    availableBrands,
    availableAttributes,
    globalAttributes,
    globalBrands,
    minPrice,
    maxPrice,
    activeFilter,
    activeSort,
    errorMessage,
    currentPage,
    lastPage,
    hasReachedMax,
    isLoadingMore,
  ];
}
