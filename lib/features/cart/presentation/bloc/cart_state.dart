import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/data/models/cart_response.dart';

part 'cart_state.freezed.dart';

enum CartSuccessType { added, removed, updated }

@freezed
abstract class CartState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus actionStatus,
    Cart? cart,
    String? errorMessage,
    CartSuccessType? successType,
  }) = _CartState;

  int get cartCount => cart?.items.length ?? 0;
}
