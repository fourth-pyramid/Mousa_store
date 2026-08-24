import 'package:mousa_store/features/favorites/services/favorite_service.dart';

class FavoriteRepo {
  FavoriteRepo({required this.service});
  final FavoriteService service;

  Future<void> addFavorite({required int productId}) async =>
      service.addFavorite(productId: productId);

  Future<dynamic> getFavorites() async {
    final response = await service.getFavorites();
    return response.data;
  }

  Future<void> removeFavorite({required int productId}) async =>
      service.removeFavorite(productId: productId);
}
