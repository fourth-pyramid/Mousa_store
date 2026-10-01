import 'package:mousa_store/features/product/data/models/product_details_response.dart';
import 'package:mousa_store/features/product/domain/repositories/product_repository.dart';

class GetProductUseCase {
  const GetProductUseCase(this._repository);

  final ProductRepository _repository;

  Future<ProductDetailsResponse> call({required int productId}) =>
      _repository.getProduct(productId: productId);
}

class AddReviewUseCase {
  const AddReviewUseCase(this._repository);

  final ReviewRepository _repository;

  Future<void> call({
    required int productId,
    required double rate,
    required String comment,
  }) => _repository.addReview(
    productId: productId,
    rate: rate,
    comment: comment,
  );
}
