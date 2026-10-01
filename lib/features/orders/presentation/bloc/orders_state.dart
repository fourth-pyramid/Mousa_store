import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/orders/data/models/order_model.dart';

part 'orders_state.freezed.dart';

enum OrdersStatus { initial, loading, success, failure }

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default(OrdersStatus.initial) OrdersStatus status,
    @Default([]) List<OrderModel> orders,
    String? errorMessage,
  }) = _OrdersState;
}
