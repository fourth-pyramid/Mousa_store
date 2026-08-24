import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

class CartService {
  Future<Response<dynamic>> getCart() async {
    try {
      return await DioHelper.getData(url: 'carts');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> addToCart({
    required int propertyId,
    required int quantity,
  }) async {
    try {
      return await DioHelper.postData(
        url: 'carts',
        data: {'property_id': propertyId, 'quantity': quantity},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      return await DioHelper.putData(
        url: 'carts/$cartItemId',
        data: {'quantity': quantity},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    try {
      await DioHelper.deleteData(url: 'carts/$cartItemId');
    } catch (e) {
      rethrow;
    }
  }
}
