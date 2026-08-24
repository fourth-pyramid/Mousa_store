import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.product,
    this.errorMessage,
  });

  final ProductStatus status;
  final ProductDetailsResponse? product;
  final String? errorMessage;

  ProductState copyWith({
    ProductStatus? status,
    ProductDetailsResponse? product,
    String? errorMessage,
  }) => ProductState(
    status: status ?? this.status,
    product: product ?? this.product,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, product, errorMessage];
}
