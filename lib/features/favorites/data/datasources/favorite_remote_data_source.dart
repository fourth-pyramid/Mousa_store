import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<Product>> getFavorites();
  Future<void> addFavorite(int productId);
  Future<void> removeFavorite(int productId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  const FavoriteRemoteDataSourceImpl();

  @override
  Future<List<Product>> getFavorites() async {
    try {
      final response = await DioHelper.getData(url: 'favorites');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final innerData = data['data'];
        if (innerData is Map<String, dynamic>) {
          final list = innerData['data'];
          if (list is List<dynamic>) {
            final products = <Product>[];
            for (final item in list) {
              if (item is Map<String, dynamic>) {
                try {
                  products.add(Product.fromJson(item));
                } on Object {
                  // Ignore single item parsing failures
                }
              }
            }
            return products;
          }
        }
      }
      return [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> addFavorite(int productId) async {
    await DioHelper.postData(
      url: 'addFavorite',
      data: {'product_id': productId},
    );
  }

  @override
  Future<void> removeFavorite(int productId) async {
    await DioHelper.postData(
      url: 'removeFavorite',
      data: {'product_id': productId},
    );
  }
}
