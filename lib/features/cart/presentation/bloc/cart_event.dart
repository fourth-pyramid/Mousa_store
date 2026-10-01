import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_event.freezed.dart';

@freezed
sealed class CartEvent with _$CartEvent {
  const factory CartEvent.fetchRequested({
    @Default(false) bool silent,
  }) = CartFetchRequested;

  const factory CartEvent.itemAdded({
    required int propertyId,
    required int quantity,
  }) = CartItemAdded;

  const factory CartEvent.quantityUpdated({
    required int cartItemId,
    required int quantity,
  }) = CartQuantityUpdated;

  const factory CartEvent.itemRemoved({
    required int cartItemId,
  }) = CartItemRemoved;

  const factory CartEvent.resetRequested() = CartResetRequested;
}
