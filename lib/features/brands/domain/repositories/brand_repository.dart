import 'package:mousa_store/features/brands/domain/entities/brand.dart';

abstract class BrandRepository {
  void invalidateCache();
  Future<List<Brand>> getBrands();
}
