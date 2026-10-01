import 'package:mousa_store/features/brands/domain/entities/brand.dart';

abstract class BrandRepository {
  Future<List<Brand>> getBrands();
}
