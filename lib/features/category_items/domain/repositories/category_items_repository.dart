import 'package:mousa_store/features/category_items/data/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_items_response.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';

abstract class CategoryItemsRepository {
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
  });

  Future<AttributeResponse> getGlobalAttributes();
}
