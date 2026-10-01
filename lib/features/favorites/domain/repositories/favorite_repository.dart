import 'package:mousa_store/features/product/data/models/product.dart';

abstract class FavoriteRepository {
  Future<List<Product>> getFavorites();
  Future<void> addFavorite(int productId);
  Future<void> removeFavorite(int productId);
}
