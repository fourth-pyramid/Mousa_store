import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/brands/domain/repositories/brand_repository.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/categories/domain/repositories/category_repository.dart';
import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/home/domain/repositories/home_repository.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';

/// Domain UseCase that coordinates multiple repositories (Home, Category, Brand)
/// ensuring repositories remain decoupled and do not depend on each other.
class FetchHomeDataUseCase {
  const FetchHomeDataUseCase({
    required HomeRepository homeRepository,
    required CategoryRepository categoryRepo,
    required BrandRepository brandRepo,
  }) : _homeRepository = homeRepository,
       _categoryRepo = categoryRepo,
       _brandRepo = brandRepo;

  final HomeRepository _homeRepository;
  final CategoryRepository _categoryRepo;
  final BrandRepository _brandRepo;

  Future<List<BannerModel>> getBanners() => _homeRepository.getBanners();

  Future<List<Brand>> getBrands() => _brandRepo.getBrands();

  Future<List<Category>> getCategories() => _categoryRepo.getCategories();

  Future<ProductListResponse> getProducts({int page = 1}) =>
      _homeRepository.getProducts(page: page);

  Future<ProductListResponse> getOfferItems({int page = 1}) =>
      _homeRepository.getOfferItems(page: page);

  Future<ProductListResponse> getRecentlyItems({int page = 1}) =>
      _homeRepository.getRecentlyItems(page: page);
}
