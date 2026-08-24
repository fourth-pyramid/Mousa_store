import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/repo/product_repo.dart';
import 'package:mousa_store/features/product/view_model/product_cubit/product_cubit.dart';
import 'package:mousa_store/features/product/view_model/product_cubit/product_state.dart';

class MockProductRepo extends Mock implements ProductRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProductRepo mockProductRepo;

  setUp(() {
    mockProductRepo = MockProductRepo();
  });

  final sampleDetail = ProductDetail(
    id: 5,
    minQuantity: 1,
    stock: 10,
    name: 'Basketball',
    desc: 'Official indoor/outdoor ball',
  );

  final sampleResponse = ProductDetailsResponse(
    success: true,
    message: 'Success',
    data: sampleDetail,
  );

  group('ProductCubit Tests', () {
    test('initial state is default ProductState', () async {
      final cubit = ProductCubit(repository: mockProductRepo);
      expect(cubit.state.status, equals(ProductStatus.initial));
      await cubit.close();
    });

    blocTest<ProductCubit, ProductState>(
      'fetchProduct emits [loading, success] when product is fetched',
      build: () {
        when(
          () => mockProductRepo.getProduct(productId: 5),
        ).thenAnswer((_) async => sampleResponse);
        return ProductCubit(repository: mockProductRepo);
      },
      act: (cubit) => cubit.fetchProduct(productId: 5),
      expect: () => [
        const ProductState(status: ProductStatus.loading),
        ProductState(status: ProductStatus.success, product: sampleResponse),
      ],
    );
  });
}
