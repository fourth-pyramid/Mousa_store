import 'package:mousa_store/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/home/domain/repositories/home_repository.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<List<BannerModel>> getBanners() async {
    final data = await _remoteDataSource.getBanners();
    return data
        .map((e) => BannerModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<ProductListResponse> getProducts({int page = 1}) async {
    final data = await _remoteDataSource.getProducts(page: page);
    return ProductListResponse.fromJson(data);
  }

  @override
  Future<ProductListResponse> getOfferItems({int page = 1}) async {
    final data = await _remoteDataSource.getOfferItems(page: page);
    return ProductListResponse.fromJson(data);
  }

  @override
  Future<ProductListResponse> getRecentlyItems({int page = 1}) async {
    final data = await _remoteDataSource.getRecentlyItems(page: page);
    return ProductListResponse.fromJson(data);
  }
}
