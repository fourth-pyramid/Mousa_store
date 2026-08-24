import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/service/product_service.dart';

class ProductRepo {
  ProductRepo({required this.service});
  final ProductService service;

  Future<ProductDetailsResponse> getProduct({required int productId}) async =>
      service.getProduct(productId: productId);
}
