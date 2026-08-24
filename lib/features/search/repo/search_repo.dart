import 'package:dio/dio.dart';
import 'package:mousa_store/features/product/model/product_list_response.dart';
import 'package:mousa_store/features/search/service/search_service.dart';

class SearchRepo {
  SearchRepo(this._searchService);
  final SearchService _searchService;

  Future<ProductListResponse> searchProducts(
    String searchText, {
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  }) async {
    final response = await _searchService.getSearchProducts(
      searchText: searchText,
      page: page,
      perPage: perPage,
      cancelToken: cancelToken,
    );
    return ProductListResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
