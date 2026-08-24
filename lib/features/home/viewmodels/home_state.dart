import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/categories/models/category.dart';
import 'package:mousa_store/features/home/models/banner_model.dart';
import 'package:mousa_store/features/product/model/product.dart';

enum RequestStatus { initial, loading, success, failure }

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.bannerStatus = RequestStatus.initial,
    this.banners = const [],
    this.brandsStatus = RequestStatus.initial,
    this.brands = const [],
    this.categoriesStatus = RequestStatus.initial,
    this.categories = const [],
    this.offersStatus = RequestStatus.initial,
    this.offerProducts = const [],
    this.recentlyStatus = RequestStatus.initial,
    this.recentlyProducts = const [],
    this.allProductsStatus = RequestStatus.initial,
    this.allProductsPaginationStatus = RequestStatus.initial,
    this.allProducts = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  final RequestStatus bannerStatus;
  final List<BannerModel> banners;

  final RequestStatus brandsStatus;
  final List<Brand> brands;

  final RequestStatus categoriesStatus;
  final List<Category> categories;

  final RequestStatus offersStatus;
  final List<Product> offerProducts;

  final RequestStatus recentlyStatus;
  final List<Product> recentlyProducts;

  final RequestStatus allProductsStatus;
  final RequestStatus allProductsPaginationStatus;
  final List<Product> allProducts;
  final int currentPage;
  final int lastPage;
  final bool hasReachedMax;

  final String? errorMessage;

  HomeState copyWith({
    RequestStatus? bannerStatus,
    List<BannerModel>? banners,
    RequestStatus? brandsStatus,
    List<Brand>? brands,
    RequestStatus? categoriesStatus,
    List<Category>? categories,
    RequestStatus? offersStatus,
    List<Product>? offerProducts,
    RequestStatus? recentlyStatus,
    List<Product>? recentlyProducts,
    RequestStatus? allProductsStatus,
    RequestStatus? allProductsPaginationStatus,
    List<Product>? allProducts,
    int? currentPage,
    int? lastPage,
    bool? hasReachedMax,
    String? errorMessage,
  }) => HomeState(
    bannerStatus: bannerStatus ?? this.bannerStatus,
    banners: banners ?? this.banners,
    brandsStatus: brandsStatus ?? this.brandsStatus,
    brands: brands ?? this.brands,
    categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    categories: categories ?? this.categories,
    offersStatus: offersStatus ?? this.offersStatus,
    offerProducts: offerProducts ?? this.offerProducts,
    recentlyStatus: recentlyStatus ?? this.recentlyStatus,
    recentlyProducts: recentlyProducts ?? this.recentlyProducts,
    allProductsStatus: allProductsStatus ?? this.allProductsStatus,
    allProductsPaginationStatus:
        allProductsPaginationStatus ?? this.allProductsPaginationStatus,
    allProducts: allProducts ?? this.allProducts,
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    bannerStatus,
    banners,
    brandsStatus,
    brands,
    categoriesStatus,
    categories,
    offersStatus,
    offerProducts,
    recentlyStatus,
    recentlyProducts,
    allProductsStatus,
    allProductsPaginationStatus,
    allProducts,
    currentPage,
    lastPage,
    hasReachedMax,
    errorMessage,
  ];
}
