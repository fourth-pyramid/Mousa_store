import 'package:mousa_store/features/product/data/models/product_details_response.dart';

abstract class ProductRepository {
  Future<ProductDetailsResponse> getProduct({required int productId});
}

abstract class ReviewRepository {
  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  });
}
