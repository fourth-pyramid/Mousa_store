import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/categories/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this.repository);

  final CategoryRepository repository;

  Future<List<Category>> call() => repository.getCategories();
}
