import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.freezed.dart';

@freezed
sealed class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchRequested({
    required int productId,
    @Default(true) bool showLoading,
  }) = ProductFetchRequested;

  const factory ProductEvent.refreshRequested({
    @Default(true) bool showLoading,
  }) = ProductRefreshRequested;
}
