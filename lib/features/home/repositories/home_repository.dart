import 'package:mousa_store/features/home/models/banner_model.dart';
import 'package:mousa_store/features/home/services/home_service.dart';
import 'package:mousa_store/features/product/model/product_list_response.dart';

class HomeRepository {
  HomeRepository({required HomeService homeService})
    : _homeService = homeService;

  final HomeService _homeService;

  Future<List<BannerModel>> getBanners() async {
    final data = await _homeService.getBanners();
    return data
        .map((e) => BannerModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<ProductListResponse> getProducts({int page = 1}) async {
    final data = await _homeService.getProducts(page: page);
    return ProductListResponse.fromJson(data);
  }

  Future<ProductListResponse> getOfferItems({int page = 1}) async {
    final data = await _homeService.getOfferItems(page: page);
    return ProductListResponse.fromJson(data);
  }

  Future<ProductListResponse> getRecentlyItems({int page = 1}) async {
    final data = await _homeService.getRecentlyItems(page: page);
    return ProductListResponse.fromJson(data);
  }
}
