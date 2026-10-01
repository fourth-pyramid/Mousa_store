abstract class CheckoutRepository {
  Future<String> checkout({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  });

  Future<String> getShippingFee({int? governorateId});
}
