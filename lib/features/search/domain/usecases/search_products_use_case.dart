import 'package:dio/dio.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';
import 'package:mousa_store/features/search/domain/repositories/search_repository.dart';

class SearchProductsUseCase {
  const SearchProductsUseCase(this._repository);

  final SearchRepository _repository;

  Future<ProductListResponse> call(
    String searchText, {
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  }) => _repository.searchProducts(
    searchText,
    page: page,
    perPage: perPage,
    cancelToken: cancelToken,
  );
}
