import 'package:mousa_store/core/service/dio_helper.dart';

class ReviewService {
  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  }) async {
    try {
      await DioHelper.postData(
        url: 'reviews/create',
        data: {
          'rate': rate.toInt().toString(),
          'comment': comment,
          'product_id': productId.toString(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
