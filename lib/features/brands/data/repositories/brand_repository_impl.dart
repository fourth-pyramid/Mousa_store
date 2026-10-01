import 'package:mousa_store/features/brands/data/datasources/brand_remote_data_source.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/brands/domain/repositories/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  const BrandRepositoryImpl({required this.remoteDataSource});

  final BrandRemoteDataSource remoteDataSource;

  @override
  Future<List<Brand>> getBrands() async => remoteDataSource.getBrands();
}
