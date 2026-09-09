import 'package:mousa_store/features/cart/services/checkout_service.dart';

class CheckoutRepo {
  CheckoutRepo({required this.service});
  final CheckoutService service;

  Future<String> checkout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) async {
    final response = await service.postCheckout(
      userAddress: userAddress,
      userName: userName,
      userPhone: userPhone,
      governorateId: governorateId,
    );

    final data = response.data as Map<String, dynamic>;

    if (data.containsKey('order')) {
      // Scenario 1: Success
      return (data['message'] ?? 'Order created successfully').toString();
    } else {
      // Scenario 2: Out of stock or other issues with success: true but no order
      final message = (data['message'] ?? 'Something went wrong').toString();
      throw Exception(message);
    }
  }

  Future<String> getShippingFee({int? governorateId}) async {
    try {
      final response = await service.getShippingFee();
      // ignore: avoid_dynamic_calls // response.data is untyped dynamic from DioResponse prior to cast
      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as List;

      if (governorateId != null) {
        // Try to find matching governorate
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

      // Default to 0 if no governorateId provided or data is empty
      return '0';
    } catch (e) {
      rethrow;
    }
  }
}
