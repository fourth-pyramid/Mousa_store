import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

class CheckoutService {
  Future<Response<dynamic>> postCheckout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) async {
    try {
      return await DioHelper.postData(
        url: 'checkouts',
        data: {
          'user_address': userAddress,
          'user_name': userName,
          'user_phone': userPhone,
          'governorate_id': governorateId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> getShippingFee() async {
    try {
      return await DioHelper.getData(url: 'shippings');
    } catch (e) {
      rethrow;
    }
  }
}
