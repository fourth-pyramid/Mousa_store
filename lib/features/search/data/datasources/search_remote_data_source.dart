import 'package:dio/dio.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

abstract class SearchRemoteDataSource {
  Future<Response<dynamic>> searchProducts({
    required String searchText,
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  const SearchRemoteDataSourceImpl();

  @override
  Future<Response<dynamic>> searchProducts({
    required String searchText,
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  }) => DioHelper.getData(
    url: 'search',
    query: {'search': searchText, 'page': page, 'per_page': perPage},
    cancelToken: cancelToken,
  );
}
