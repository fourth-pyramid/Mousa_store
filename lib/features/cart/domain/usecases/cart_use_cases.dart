import 'package:mousa_store/features/cart/data/models/cart_response.dart';
import 'package:mousa_store/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  const GetCartUseCase(this._repository);

  final CartRepository _repository;

  Future<CartResponse> call() => _repository.getCart();
}

class AddToCartUseCase {
  const AddToCartUseCase(this._repository);

  final CartRepository _repository;

  Future<CartResponse> call({
    required int propertyId,
    required int quantity,
  }) => _repository.addToCart(propertyId: propertyId, quantity: quantity);
}

class UpdateCartItemUseCase {
  const UpdateCartItemUseCase(this._repository);

  final CartRepository _repository;

  Future<CartResponse> call({
    required int cartItemId,
    required int quantity,
  }) => _repository.updateCartItem(cartItemId: cartItemId, quantity: quantity);
}

class RemoveFromCartUseCase {
  const RemoveFromCartUseCase(this._repository);

  final CartRepository _repository;

  Future<void> call({required int cartItemId}) =>
      _repository.removeFromCart(cartItemId: cartItemId);
}
