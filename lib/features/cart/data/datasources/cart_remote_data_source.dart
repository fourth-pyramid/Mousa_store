import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

abstract class CartRemoteDataSource {
  Future<Response<dynamic>> getCart();

  Future<Response<dynamic>> addToCart({
    required int propertyId,
    required int quantity,
  });

  Future<Response<dynamic>> updateCartItem({
    required int cartItemId,
    required int quantity,
  });

  Future<void> removeFromCart({required int cartItemId});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl();

  @override
  Future<Response<dynamic>> getCart() async {
    try {
      return await DioHelper.getData(url: 'carts');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> addToCart({
    required int propertyId,
    required int quantity,
  }) async {
    try {
      return await DioHelper.postData(
        url: 'carts',
        data: {'property_id': propertyId, 'quantity': quantity},
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      return await DioHelper.putData(
        url: 'carts/$cartItemId',
        data: {'quantity': quantity},
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart({required int cartItemId}) async {
    try {
      await DioHelper.deleteData(url: 'carts/$cartItemId');
    } catch (_) {
      rethrow;
    }
  }
}
