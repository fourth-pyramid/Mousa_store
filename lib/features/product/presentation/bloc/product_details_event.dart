import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';

part 'product_details_event.freezed.dart';

@freezed
sealed class ProductDetailsEvent with _$ProductDetailsEvent {
  const factory ProductDetailsEvent.started(ProductDetail product) =
      ProductDetailsStarted;

  const factory ProductDetailsEvent.attributeChanged({
    required String key,
    required String value,
  }) = ProductDetailsAttributeChanged;

  const factory ProductDetailsEvent.quantityChanged(int quantity) =
      ProductDetailsQuantityChanged;

  const factory ProductDetailsEvent.productUpdated(ProductDetail product) =
      ProductDetailsProductUpdated;
}
