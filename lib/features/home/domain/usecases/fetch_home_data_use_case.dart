import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/brands/repositories/brand_repo.dart';
import 'package:mousa_store/features/categories/models/category.dart';
import 'package:mousa_store/features/categories/repositories/category_repo.dart';
import 'package:mousa_store/features/home/models/banner_model.dart';
import 'package:mousa_store/features/home/repositories/home_repository.dart';
import 'package:mousa_store/features/product/model/product_list_response.dart';

/// Domain UseCase that coordinates multiple repositories (Home, Category, Brand)
/// ensuring repositories remain decoupled and do not depend on each other.
class FetchHomeDataUseCase {
  FetchHomeDataUseCase({
    required HomeRepository homeRepository,
    required CategoryRepo categoryRepo,
    required BrandRepo brandRepo,
  }) : _homeRepository = homeRepository,
       _categoryRepo = categoryRepo,
       _brandRepo = brandRepo;

  final HomeRepository _homeRepository;
  final CategoryRepo _categoryRepo;
  final BrandRepo _brandRepo;

  Future<List<BannerModel>> getBanners() => _homeRepository.getBanners();

  Future<List<Brand>> getBrands() => _brandRepo.fetchBrands();

  Future<List<Category>> getCategories() => _categoryRepo.fetchCategories();

  Future<ProductListResponse> getProducts({int page = 1}) =>
      _homeRepository.getProducts(page: page);

  Future<ProductListResponse> getOfferItems({int page = 1}) =>
      _homeRepository.getOfferItems(page: page);

  Future<ProductListResponse> getRecentlyItems({int page = 1}) =>
      _homeRepository.getRecentlyItems(page: page);
}
