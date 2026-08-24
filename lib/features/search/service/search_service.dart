import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/service/dio_helper.dart';

class SearchService {
  Future<Response<dynamic>> getSearchProducts({
    required String searchText,
    int page = 1,
    int perPage = 10,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await DioHelper.getData(
        url: 'search',
        query: {'search': searchText, 'page': page, 'per_page': perPage},
        cancelToken: cancelToken,
      );

      return response;
    } catch (e) {
      debugPrint('❌ Search Service Error: $e');
      rethrow;
    }
  }
}
