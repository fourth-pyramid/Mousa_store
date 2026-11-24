import 'package:mousa_store/features/categories/domain/entities/category.dart';

abstract class CategoryRepository {
  void invalidateCache();
  Future<List<Category>> getCategories();
}
