import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';

class ProductService {
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

      // ponytail: validate product exists and has valid info
      if (product.data.id == 0 || (product.data.name.isEmpty && product.data.displayPrice == '0')) {
        throw Exception('Product not found');
      }

      return product;
    } catch (e) {
      rethrow;
    }
  }
}
