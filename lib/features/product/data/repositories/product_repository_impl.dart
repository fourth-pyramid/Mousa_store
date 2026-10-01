import 'package:mousa_store/features/product/data/datasources/product_remote_data_source.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';
import 'package:mousa_store/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<ProductDetailsResponse> getProduct({required int productId}) =>
      _remoteDataSource.getProduct(productId: productId);
}

class ReviewRepositoryImpl implements ReviewRepository {
  const ReviewRepositoryImpl(this._remoteDataSource);

  final ReviewRemoteDataSource _remoteDataSource;

  @override
  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  }) => _remoteDataSource.addReview(
    productId: productId,
    rate: rate,
    comment: comment,
  );
}
