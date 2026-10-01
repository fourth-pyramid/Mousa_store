import 'package:dio/dio.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';
import 'package:mousa_store/features/search/data/datasources/search_remote_data_source.dart';
import 'package:mousa_store/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._remoteDataSource);

  final SearchRemoteDataSource _remoteDataSource;

  @override
  Future<ProductListResponse> searchProducts(
    String searchText, {
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  }) async {
    final response = await _remoteDataSource.searchProducts(
      searchText: searchText,
      page: page,
      perPage: perPage,
      cancelToken: cancelToken,
    );
    return ProductListResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
