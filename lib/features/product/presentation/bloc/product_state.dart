import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';

part 'product_state.freezed.dart';

enum ProductStatus { initial, loading, success, failure }

@freezed
sealed class ProductState with _$ProductState {
  const factory ProductState({
    @Default(ProductStatus.initial) ProductStatus status,
    ProductDetailsResponse? product,
    String? errorMessage,
  }) = _ProductState;
}
