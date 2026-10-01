import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

part 'home_state.freezed.dart';

enum RequestStatus { initial, loading, success, failure }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(RequestStatus.initial) RequestStatus bannerStatus,
    @Default([]) List<BannerModel> banners,
    @Default(RequestStatus.initial) RequestStatus brandsStatus,
    @Default([]) List<Brand> brands,
    @Default(RequestStatus.initial) RequestStatus categoriesStatus,
    @Default([]) List<Category> categories,
    @Default(RequestStatus.initial) RequestStatus offersStatus,
    @Default([]) List<Product> offerProducts,
    @Default(RequestStatus.initial) RequestStatus recentlyStatus,
    @Default([]) List<Product> recentlyProducts,
    @Default(RequestStatus.initial) RequestStatus allProductsStatus,
    @Default(RequestStatus.initial) RequestStatus allProductsPaginationStatus,
    @Default([]) List<Product> allProducts,
    @Default(1) int currentPage,
    @Default(1) int lastPage,
    @Default(false) bool hasReachedMax,
    String? errorMessage,
  }) = _HomeState;
}
