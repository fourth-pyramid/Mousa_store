import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details_event.freezed.dart';

@freezed
sealed class OrderDetailsEvent with _$OrderDetailsEvent {
  const factory OrderDetailsEvent.fetchRequested(int orderId) =
      OrderDetailsFetchRequested;
}
