import 'package:mousa_store/features/cart/models/cart_response.dart';
// import '../../../core/service/cart_service.dart';
import 'package:mousa_store/features/cart/services/cart_service.dart';

class CartRepo {
  CartRepo({required this.service});
  final CartService service;

  Future<CartResponse> getCart() async {
    final response = await service.getCart();
    return CartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<CartResponse> addToCart({
    required int propertyId,
    required int quantity,
  }) async {
    final response = await service.addToCart(
      propertyId: propertyId,
      quantity: quantity,
    );
    return CartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<CartResponse> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    final response = await service.updateCartItem(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    return CartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    await service.removeFromCart(cartItemId: cartItemId);
  }
}
