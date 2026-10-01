import 'package:mousa_store/features/favorites/domain/repositories/favorite_repository.dart';

class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase(this.repository);

  final FavoriteRepository repository;

  Future<void> add(int productId) => repository.addFavorite(productId);

  Future<void> remove(int productId) => repository.removeFavorite(productId);
}
