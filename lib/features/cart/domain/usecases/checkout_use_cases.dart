import 'package:mousa_store/features/cart/domain/repositories/checkout_repository.dart';

class CheckoutUseCase {
  const CheckoutUseCase(this._repository);

  final CheckoutRepository _repository;

  Future<String> call({
    required String userAddress,
    required String userName,
    required String userPhone,
    int? governorateId,
  }) => _repository.checkout(
    userAddress: userAddress,
    userName: userName,
    userPhone: userPhone,
    governorateId: governorateId,
  );
}

class GetShippingFeeUseCase {
  const GetShippingFeeUseCase(this._repository);

  final CheckoutRepository _repository;

  Future<String> call({int? governorateId}) =>
      _repository.getShippingFee(governorateId: governorateId);
}
