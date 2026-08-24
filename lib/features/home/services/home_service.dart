import 'package:mousa_store/core/service/dio_helper.dart';

class HomeService {
  Future<List<dynamic>> getBanners() async {
    try {
      final response = await DioHelper.getData(url: 'banners');
      if (response.data is Map) {
        final data = response.data as Map;
        if (data['data'] is List) {
          return data['data'] as List<dynamic>;
        }
        return [];
      }
      if (response.data is List) {
        return response.data as List<dynamic>;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProducts({int page = 1}) async {
    try {
      final response = await DioHelper.getData(url: 'products?page=$page');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getOfferItems({int page = 1}) async {
    try {
      final response = await DioHelper.getData(
        url: 'filter/product?sort=offers&page=$page',
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRecentlyItems({int page = 1}) async {
    try {
      final response = await DioHelper.getData(
        url: 'latset-product?page=$page',
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
