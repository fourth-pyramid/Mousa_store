import 'package:mousa_store/features/category_items/data/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_items_response.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/domain/repositories/category_items_repository.dart';

class GetCategoryItemsUseCase {
  const GetCategoryItemsUseCase(this._repository);

  final CategoryItemsRepository _repository;

  Future<CategoryItemsResponse> call({
    required ItemFetchType fetchType,
    int? categoryId,
    int page = 1,
    int perPage = 20,
    int? brandId,
    List<int>? attributeIds,
    String? sort,
    double? minPrice,
    double? maxPrice,
  }) => _repository.getItems(
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
}

class GetGlobalAttributesUseCase {
  const GetGlobalAttributesUseCase(this._repository);

  final CategoryItemsRepository _repository;

  Future<AttributeResponse> call() => _repository.getGlobalAttributes();
}
