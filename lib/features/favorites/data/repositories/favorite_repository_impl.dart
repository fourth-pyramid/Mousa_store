import 'package:mousa_store/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:mousa_store/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  const FavoriteRepositoryImpl({required this.remoteDataSource});

  final FavoriteRemoteDataSource remoteDataSource;

  @override
  Future<List<Product>> getFavorites() => remoteDataSource.getFavorites();

  @override
  Future<void> addFavorite(int productId) =>
      remoteDataSource.addFavorite(productId);

  @override
  Future<void> removeFavorite(int productId) =>
      remoteDataSource.removeFavorite(productId);
}
