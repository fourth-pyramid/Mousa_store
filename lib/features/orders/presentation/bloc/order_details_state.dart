import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/orders/data/models/order_details_model.dart';

part 'order_details_state.freezed.dart';

enum OrderDetailsStatus { initial, loading, success, failure }

@freezed
abstract class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    @Default(OrderDetailsStatus.initial) OrderDetailsStatus status,
    OrderDetailsData? orderDetails,
    String? errorMessage,
  }) = _OrderDetailsState;
}
