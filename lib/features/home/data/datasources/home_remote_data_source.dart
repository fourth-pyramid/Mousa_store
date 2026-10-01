import 'package:mousa_store/core/service/dio_helper.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<dynamic>> getBanners();
  Future<Map<String, dynamic>> getProducts({int page = 1});
  Future<Map<String, dynamic>> getOfferItems({int page = 1});
  Future<Map<String, dynamic>> getRecentlyItems({int page = 1});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl();

  @override
  Future<List<dynamic>> getBanners() async {
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
  }

  @override
  Future<Map<String, dynamic>> getProducts({int page = 1}) async {
    final response = await DioHelper.getData(url: 'products?page=$page');
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getOfferItems({int page = 1}) async {
    final response = await DioHelper.getData(
      url: 'filter/product?sort=offers&page=$page',
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getRecentlyItems({int page = 1}) async {
    final response = await DioHelper.getData(
      url: 'latset-product?page=$page',
    );
    return response.data as Map<String, dynamic>;
  }
}
