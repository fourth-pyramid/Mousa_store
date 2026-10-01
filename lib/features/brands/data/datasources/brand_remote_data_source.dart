import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/brands/data/models/brand_model.dart';

abstract class BrandRemoteDataSource {
  Future<List<BrandModel>> getBrands();
}

class BrandRemoteDataSourceImpl implements BrandRemoteDataSource {
  const BrandRemoteDataSourceImpl();

  @override
  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await DioHelper.getData(url: 'brands');

      if (response.data is Map<String, dynamic>) {
        final dataMap = response.data as Map<String, dynamic>;
        if (dataMap['success'] == true || dataMap['status'] == true) {
          final data = dataMap['data'];

          if (data is List) {
            return data
                .whereType<Map<String, dynamic>>()
                .map(BrandModel.fromJson)
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      debugPrint('BrandRemoteDataSource Error: $e');
      rethrow;
    }
  }
}
