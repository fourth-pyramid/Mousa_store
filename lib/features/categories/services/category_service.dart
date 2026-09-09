// ignore_for_file: avoid_dynamic_calls // Unstructured JSON responses from remote categories endpoint

import 'package:flutter/rendering.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/categories/models/category.dart';

class CategoryService {
  Future<List<Category>> getCategories() async {
    try {
      final response = await DioHelper.getData(url: 'categories');

      if (response.data is Map<String, dynamic>) {
        final dataMap = response.data as Map<String, dynamic>;
        if (dataMap['success'] == true) {
          final data = dataMap['data'];

          if (data is List) {
            return data
                .whereType<Map<String, dynamic>>()
                .map(Category.fromJson)
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      debugPrint('CategoryService Error: $e');
      rethrow;
    }
  }
}
