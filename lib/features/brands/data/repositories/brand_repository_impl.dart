import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/ttl_cache.dart';
import 'package:mousa_store/features/brands/data/datasources/brand_remote_data_source.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/brands/domain/repositories/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  BrandRepositoryImpl({required this.remoteDataSource});

  final BrandRemoteDataSource remoteDataSource;

  final _cache = TtlCache<List<Brand>>();
  @override
  void invalidateCache() => _cache.clear();

  @override
  Future<List<Brand>> getBrands() =>
      _cache.get(CacheHelper.catalogCacheKey, remoteDataSource.getBrands);
}
