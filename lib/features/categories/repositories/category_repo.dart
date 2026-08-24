import 'package:mousa_store/features/categories/models/category.dart';
import 'package:mousa_store/features/categories/services/category_service.dart';

class CategoryRepo {
  CategoryRepo({required this.service});
  final CategoryService service;

  Future<List<Category>> fetchCategories() async =>
      service.getCategories();
}
