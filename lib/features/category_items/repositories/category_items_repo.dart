import 'package:mousa_store/features/category_items/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_items_response.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';

class CategoryItemsRepo {
  CategoryItemsRepo({required this.service});
  final CategoryItemsService service;

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
  }) async => service.getItems(
    fetchType: fetchType,
    categoryId: categoryId,
    page: page,
    perPage: perPage,
    brandId: brandId,
    attributeIds: attributeIds,
    sort: sort,
    minPrice: minPrice,
    maxPrice: maxPrice,
  );

  Future<AttributeResponse> getGlobalAttributes() async =>
      service.getGlobalAttributes();
}
