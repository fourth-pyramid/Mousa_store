import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';
import 'package:mousa_store/features/product/domain/usecases/product_use_cases.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_bloc.dart';

class MockGetProductUseCase extends Mock implements GetProductUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetProductUseCase mockGetProductUseCase;

  setUp(() {
    mockGetProductUseCase = MockGetProductUseCase();
  });

  final sampleResponse = ProductDetailsResponse(
    success: true,
    message: 'Success',
    data: ProductDetail(
      id: 10,
      minQuantity: 1,
      stock: 100,
      name: 'Sample Shoes',
      desc: 'High quality running shoes',
    ),
  );

  group('ProductBloc Tests', () {
    test('initial state is default ProductState', () async {
      final bloc = ProductBloc(getProductUseCase: mockGetProductUseCase);
      expect(bloc.state.status, equals(ProductStatus.initial));
      await bloc.close();
    });

    blocTest<ProductBloc, ProductState>(
      'fetchProduct emits [loading, success] on successful fetch',
      build: () {
        when(
          () => mockGetProductUseCase(productId: 10),
        ).thenAnswer((_) async => sampleResponse);
        return ProductBloc(getProductUseCase: mockGetProductUseCase);
      },
      act: (bloc) => bloc.add(const ProductFetchRequested(productId: 10)),
      expect: () => [
        const ProductState(status: ProductStatus.loading),
        predicate<ProductState>(
          (s) =>
              s.status == ProductStatus.success &&
              s.product?.data.id == 10 &&
              s.product?.data.name == 'Sample Shoes',
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'fetchProduct emits [loading, failure] when error occurs',
      build: () {
        when(
          () => mockGetProductUseCase(productId: 10),
        ).thenThrow(Exception('Product not found'));
        return ProductBloc(getProductUseCase: mockGetProductUseCase);
      },
      act: (bloc) => bloc.add(const ProductFetchRequested(productId: 10)),
      expect: () => [
        const ProductState(status: ProductStatus.loading),
        predicate<ProductState>(
          (s) =>
              s.status == ProductStatus.failure &&
              s.errorMessage == 'المنتج غير متوفر حالياً أو تم حذفه',
        ),
      ],
    );
  });
}
