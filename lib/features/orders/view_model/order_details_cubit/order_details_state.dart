import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/orders/model/order_details_model.dart';

enum OrderDetailsStatus { initial, loading, success, failure }

class OrderDetailsState extends Equatable {
  const OrderDetailsState({
    this.status = OrderDetailsStatus.initial,
    this.orderDetails,
    this.errorMessage,
  });

  final OrderDetailsStatus status;
  final OrderDetailsData? orderDetails;
  final String? errorMessage;

  OrderDetailsState copyWith({
    OrderDetailsStatus? status,
    OrderDetailsData? orderDetails,
    String? errorMessage,
  }) => OrderDetailsState(
    status: status ?? this.status,
    orderDetails: orderDetails ?? this.orderDetails,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, orderDetails, errorMessage];
}
