import 'package:mousa_store/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:mousa_store/features/cart/data/models/cart_response.dart';
import 'package:mousa_store/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._remoteDataSource);

  final CartRemoteDataSource _remoteDataSource;

  @override
  Future<CartResponse> getCart() async {
    final response = await _remoteDataSource.getCart();
    return CartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CartResponse> addToCart({
    required int propertyId,
    required int quantity,
  }) async {
    final response = await _remoteDataSource.addToCart(
      propertyId: propertyId,
      quantity: quantity,
    );
    return CartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CartResponse> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    final response = await _remoteDataSource.updateCartItem(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    return CartResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> removeFromCart({required int cartItemId}) =>
      _remoteDataSource.removeFromCart(cartItemId: cartItemId);
}
