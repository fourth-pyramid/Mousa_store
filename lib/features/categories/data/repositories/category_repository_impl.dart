import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/ttl_cache.dart';
import 'package:mousa_store/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required this.remoteDataSource});

  final CategoryRemoteDataSource remoteDataSource;

  final _cache = TtlCache<List<Category>>();
  @override
  void invalidateCache() => _cache.clear();

  @override
  Future<List<Category>> getCategories() =>
      _cache.get(CacheHelper.catalogCacheKey, remoteDataSource.getCategories);
}
