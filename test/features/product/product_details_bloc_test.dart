import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/features/product/data/models/product_details_response.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_details_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final variant1 = ProductVariant(
    id: 1,
    price: '100.0',
    stock: 5,
    minQuantity: 1,
    imagePath: '',
    imagesPath: const [],
    attributes: {'color': 'Red', 'size': 'M'},
  );

  final variant2 = ProductVariant(
    id: 2,
    price: '120.0',
    stock: 0,
    minQuantity: 1,
    imagePath: '',
    imagesPath: const [],
    attributes: {'color': 'Blue', 'size': 'L'},
  );

  final variant3 = ProductVariant(
    id: 3,
    price: '130.0',
    stock: 10,
    minQuantity: 2,
    imagePath: '',
    imagesPath: const [],
    attributes: {'color': 'Blue', 'size': 'M'},
  );

  final productWithVariants = ProductDetail(
    id: 1,
    name: 'T-Shirt',
    desc: 'Cool T-Shirt',
    minQuantity: 1,
    stock: 15,
    variants: [variant1, variant2, variant3],
  );

  final productWithoutVariants = ProductDetail(
    id: 2,
    name: 'Simple Cap',
    desc: 'Basic Hat',
    minQuantity: 1,
    stock: 20,
    properties: ProductAttributes(
      values: {
        'color': ['Black', 'White'],
      },
    ),
  );

  group('ProductDetailsBloc Tests', () {
    test('initial state with variants selects first in-stock variant', () async {
      final bloc = ProductDetailsBloc(product: productWithVariants);
      expect(bloc.state.selectedVariant?.id, equals(1));
      expect(bloc.state.selectedAttributes['color'], equals('Red'));
      expect(bloc.state.selectedAttributes['size'], equals('M'));
      expect(bloc.state.selectedQuantity, equals(1));
      await bloc.close();
    });

    test('initial state without variants selects first property value', () async {
      final bloc = ProductDetailsBloc(product: productWithoutVariants);
      expect(bloc.state.selectedVariant, isNull);
      expect(bloc.state.selectedAttributes['color'], equals('Black'));
      expect(bloc.state.selectedQuantity, equals(1));
      await bloc.close();
    });

    blocTest<ProductDetailsBloc, ProductDetailsState>(
      'attributeChanged updates variant and selected attributes',
      build: () => ProductDetailsBloc(product: productWithVariants),
      act: (bloc) => bloc.add(
        const ProductDetailsEvent.attributeChanged(key: 'color', value: 'Blue'),
      ),
      expect: () => [
        predicate<ProductDetailsState>(
          (s) =>
              s.selectedVariant?.id == 3 &&
              s.selectedAttributes['color'] == 'Blue' &&
              s.selectedAttributes['size'] == 'M' &&
              s.selectedQuantity == 2,
        ),
      ],
    );

    blocTest<ProductDetailsBloc, ProductDetailsState>(
      'quantityChanged clamps quantity between minQuantity and stock',
      build: () => ProductDetailsBloc(product: productWithVariants),
      act: (bloc) {
        bloc
          ..add(const ProductDetailsEvent.quantityChanged(100))
          ..add(const ProductDetailsEvent.quantityChanged(0));
      },
      expect: () => [
        predicate<ProductDetailsState>((s) => s.selectedQuantity == 5),
        predicate<ProductDetailsState>((s) => s.selectedQuantity == 1),
      ],
    );

    test('getAvailableValues filters attributes correctly by in-stock variant', () async {
      final bloc = ProductDetailsBloc(product: productWithVariants);
      final colors = bloc.state.getAvailableValues('color');
      expect(colors, containsAll(['Red', 'Blue']));
      await bloc.close();
    });
  });
}
