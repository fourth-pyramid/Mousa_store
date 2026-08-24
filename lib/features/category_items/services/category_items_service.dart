import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/category_items/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_items_response.dart';

enum ItemFetchType { category, recently, offers, brand }

class CategoryItemsService {
  /// Get items based on fetch type with pagination
  Future<CategoryItemsResponse> getItems({
    required ItemFetchType fetchType,
    int? categoryId,
    int page = 1,
    int perPage = 20,
    int? brandId,
    List<int>? attributeIds,
    String? sort,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      String url;
      final queryParams = <String, dynamic>{};

      switch (fetchType) {
        case ItemFetchType.category:
          if (categoryId == null) {
            throw ArgumentError(
              'categoryId is required for category fetch type',
            );
          }
          url = 'filter/product';
          queryParams['category_id'] = categoryId;

          // Add filter parameters
          if (brandId != null) {
            queryParams['brand_id'] = brandId;
          }
          if (attributeIds != null && attributeIds.isNotEmpty) {
            queryParams['attribute_ids[]'] = attributeIds;
          }
          if (minPrice != null) {
            queryParams['min_price'] = minPrice;
          }
          if (maxPrice != null) {
            queryParams['max_price'] = maxPrice;
          }
          if (sort != null) {
            queryParams['sort'] = sort;
          }
          break;
        case ItemFetchType.brand:
          if (brandId == null) {
            throw ArgumentError(
              'brandId is required for brand fetch type',
            );
          }
          url = 'filter/product';
          queryParams['brand_id'] = brandId;

          if (categoryId != null) {
            queryParams['category_id'] = categoryId;
          }
          if (attributeIds != null && attributeIds.isNotEmpty) {
            queryParams['attribute_ids[]'] = attributeIds;
          }
          if (minPrice != null) {
            queryParams['min_price'] = minPrice;
          }
          if (maxPrice != null) {
            queryParams['max_price'] = maxPrice;
          }
          if (sort != null) {
            queryParams['sort'] = sort;
          }
          break;
        case ItemFetchType.recently:
          url = 'latset-product';
          break;
        case ItemFetchType.offers:
          url = 'filter/product';
          queryParams['sort'] = 'offers';
          break;
      }

      queryParams['page'] = page;
      queryParams['per_page'] = perPage;

      final response = await DioHelper.getData(url: url, query: queryParams);
      if (response.data is Map) {
        return CategoryItemsResponse.fromJson(
          Map<String, dynamic>.from(response.data as Map),
        );
      }
      throw Exception('Invalid response format');
    } catch (e) {
      rethrow;
    }
  }

  /// Get static global attributes for filtering
  Future<AttributeResponse> getGlobalAttributes() async {
    final response = await DioHelper.getData(url: 'attributes');
    if (response.data is Map) {
      return AttributeResponse.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    }
    throw Exception('Invalid response format');
  }
}
