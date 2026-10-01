import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/brands/domain/repositories/brand_repository.dart';

class GetBrandsUseCase {
  const GetBrandsUseCase(this.repository);

  final BrandRepository repository;

  Future<List<Brand>> call() => repository.getBrands();
}
