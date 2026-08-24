import 'package:mousa_store/features/product/service/review_service.dart';

class ReviewRepo {
  ReviewRepo(this._reviewService);
  final ReviewService _reviewService;

  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  }) async => _reviewService.addReview(
    productId: productId,
    rate: rate,
    comment: comment,
  );
}
