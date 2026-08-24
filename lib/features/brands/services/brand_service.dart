import 'package:flutter/rendering.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/brands/models/brand.dart';

class BrandService {
  Future<List<Brand>> getBrands() async {
    try {
      final response = await DioHelper.getData(url: 'brands');

      if (response.data is Map<String, dynamic>) {
        final dataMap = response.data as Map<String, dynamic>;
        if (dataMap['success'] == true || dataMap['status'] == true) {
          final data = dataMap['data'];

          if (data is List) {
            return data
                .whereType<Map<String, dynamic>>()
                .map(Brand.fromJson)
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      debugPrint('BrandService Error: $e');
      rethrow;
    }
  }
}
