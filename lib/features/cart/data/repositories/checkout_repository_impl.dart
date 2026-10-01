import 'package:mousa_store/features/cart/data/datasources/checkout_remote_data_source.dart';
import 'package:mousa_store/features/cart/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl(this._remoteDataSource);

  final CheckoutRemoteDataSource _remoteDataSource;

  @override
  Future<String> checkout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) async {
    final response = await _remoteDataSource.postCheckout(
      userAddress: userAddress,
      userName: userName,
      userPhone: userPhone,
      governorateId: governorateId,
    );

    final data = response.data as Map<String, dynamic>;

    if (data.containsKey('order')) {
      return (data['message'] ?? 'Order created successfully').toString();
    } else {
      final message = (data['message'] ?? 'Something went wrong').toString();
      throw Exception(message);
    }
  }

  @override
  Future<String> getShippingFee({int? governorateId}) async {
    try {
      final response = await _remoteDataSource.getShippingFee();
      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List;

      if (governorateId != null) {
        final item =
            data.firstWhere(
                  (e) =>
                      (e as Map<String, dynamic>)['governorate_id'] ==
                      governorateId,
                  orElse: () => null,
                )
                as Map<String, dynamic>?;
        if (item != null) return item['shipping'].toString();
      }

      return '0';
    } catch (_) {
      rethrow;
    }
  }
}
