import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/brands/services/brand_service.dart';

class BrandRepo {
  BrandRepo({required this.service});
  final BrandService service;

  Future<List<Brand>> fetchBrands() async => service.getBrands();
}
