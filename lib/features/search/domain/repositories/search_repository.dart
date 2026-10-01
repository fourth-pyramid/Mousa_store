import 'package:dio/dio.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';

abstract class SearchRepository {
  Future<ProductListResponse> searchProducts(
    String searchText, {
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  });
}
