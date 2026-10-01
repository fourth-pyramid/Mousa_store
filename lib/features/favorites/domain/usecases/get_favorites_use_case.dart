import 'package:mousa_store/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

class GetFavoritesUseCase {
  const GetFavoritesUseCase(this.repository);

  final FavoriteRepository repository;

  Future<List<Product>> call() => repository.getFavorites();
}
