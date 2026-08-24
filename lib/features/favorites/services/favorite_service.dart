import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

class FavoriteService {
  Future<void> addFavorite({required int productId}) async {
    try {
      await DioHelper.postData(
        url: 'addFavorite',
        data: {'product_id': productId},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> getFavorites() async {
    try {
      return await DioHelper.getData(url: 'favorites');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFavorite({required int productId}) async {
    try {
      await DioHelper.postData(
        url: 'removeFavorite',
        data: {'product_id': productId},
      );
    } catch (e) {
      rethrow;
    }
  }
}
