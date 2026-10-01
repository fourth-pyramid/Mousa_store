import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_event.freezed.dart';

@freezed
sealed class OrdersEvent with _$OrdersEvent {
  const factory OrdersEvent.fetchRequested() = OrdersFetchRequested;
  const factory OrdersEvent.searchQueryChanged(String query) =
      OrdersSearchQueryChanged;
}
