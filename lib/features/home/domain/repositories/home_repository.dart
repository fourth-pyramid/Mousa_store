import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';

abstract interface class HomeRepository {
  Future<List<BannerModel>> getBanners();
  Future<ProductListResponse> getProducts({int page = 1});
  Future<ProductListResponse> getOfferItems({int page = 1});
  Future<ProductListResponse> getRecentlyItems({int page = 1});
}
