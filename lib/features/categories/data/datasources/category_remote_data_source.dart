import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/categories/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImpl();

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await DioHelper.getData(url: 'categories');

      if (response.data is Map<String, dynamic>) {
        final dataMap = response.data as Map<String, dynamic>;
        if (dataMap['success'] == true) {
          final data = dataMap['data'];

          if (data is List) {
            return data
                .whereType<Map<String, dynamic>>()
                .map(CategoryModel.fromJson)
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      debugPrint('CategoryRemoteDataSource Error: $e');
      rethrow;
    }
  }
}
