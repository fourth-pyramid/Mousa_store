import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';

abstract class ProductRemoteDataSource {
  Future<ProductDetailsResponse> getProduct({required int productId});
}

abstract class ReviewRemoteDataSource {
  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl();

  @override
  Future<ProductDetailsResponse> getProduct({required int productId}) async {
    try {
      final response = await DioHelper.getData(
        url: 'product?product_id=$productId',
      );

      final map = response.data as Map<String, dynamic>;
      final success = map['success'] as bool? ?? false;
      final data = map['data'];

      if (!success || data == null || (data is Map && data.isEmpty)) {
        throw Exception('Product not found');
      }

      final product = ProductDetailsResponse.fromJson(map);

      if (product.data.id == 0 ||
          (product.data.name.isEmpty && product.data.displayPrice == '0')) {
        throw Exception('Product not found');
      }

      return product;
    } catch (_) {
      rethrow;
    }
  }
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  const ReviewRemoteDataSourceImpl();

  @override
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
    } catch (_) {
      rethrow;
    }
  }
}
