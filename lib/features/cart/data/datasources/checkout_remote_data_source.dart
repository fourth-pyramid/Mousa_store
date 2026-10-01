import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

abstract class CheckoutRemoteDataSource {
  Future<Response<dynamic>> postCheckout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  });

  Future<Response<dynamic>> getShippingFee();
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl();

  @override
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
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> getShippingFee() async {
    try {
      return await DioHelper.getData(url: 'shippings');
    } catch (_) {
      rethrow;
    }
  }
}
