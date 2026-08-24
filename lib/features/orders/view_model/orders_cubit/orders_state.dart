import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/orders/model/order_model.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrdersState extends Equatable {
  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const [],
    this.errorMessage,
  });

  final OrdersStatus status;
  final List<OrderModel> orders;
  final String? errorMessage;

  OrdersState copyWith({
    OrdersStatus? status,
    List<OrderModel>? orders,
    String? errorMessage,
  }) => OrdersState(
    status: status ?? this.status,
    orders: orders ?? this.orders,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, orders, errorMessage];
}
