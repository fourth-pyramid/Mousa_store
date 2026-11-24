import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/ttl_cache.dart';
import 'package:mousa_store/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/home/domain/repositories/home_repository.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final HomeRemoteDataSource _remoteDataSource;

  final _cache = TtlCache<List<BannerModel>>();
  @override
  void invalidateCache() => _cache.clear();

  @override
  Future<List<BannerModel>> getBanners() => _cache.get(
    CacheHelper.catalogCacheKey,
    () async {
      final data = await _remoteDataSource.getBanners();
      return data
          .map((e) => BannerModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    },
  );

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
