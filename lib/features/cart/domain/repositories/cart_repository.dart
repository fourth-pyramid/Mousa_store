import 'package:mousa_store/features/cart/data/models/cart_response.dart';

abstract class CartRepository {
  Future<CartResponse> getCart();

  Future<CartResponse> addToCart({
    required int propertyId,
    required int quantity,
  });

  Future<CartResponse> updateCartItem({
    required int cartItemId,
    required int quantity,
  });

  Future<void> removeFromCart({required int cartItemId});
}
