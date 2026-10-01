import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/data/models/cart_response.dart';
import 'package:mousa_store/features/cart/domain/usecases/cart_use_cases.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';

class MockGetCartUseCase extends Mock implements GetCartUseCase {}

class MockAddToCartUseCase extends Mock implements AddToCartUseCase {}

class MockUpdateCartItemUseCase extends Mock implements UpdateCartItemUseCase {}

class MockRemoveFromCartUseCase extends Mock implements RemoveFromCartUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetCartUseCase mockGetCartUseCase;
  late MockAddToCartUseCase mockAddToCartUseCase;
  late MockUpdateCartItemUseCase mockUpdateCartItemUseCase;
  late MockRemoveFromCartUseCase mockRemoveFromCartUseCase;

  setUp(() {
    mockGetCartUseCase = MockGetCartUseCase();
    mockAddToCartUseCase = MockAddToCartUseCase();
    mockUpdateCartItemUseCase = MockUpdateCartItemUseCase();
    mockRemoveFromCartUseCase = MockRemoveFromCartUseCase();
  });

  const sampleCartItem = CartItem(
    id: 1,
    name: 'Sports Shoes',
    desc: 'Comfortable running shoes',
    price: '100.0',
    imagePath: 'https://example.com/shoe.png',
    imagesPath: [],
    quantity: 2,
    lineTotal: 200.0,
  );

  const sampleCart = Cart(
    id: 10,
    userId: 5,
    total: 200.0,
    items: [sampleCartItem],
  );

  CartBloc createBloc() => CartBloc(
    getCartUseCase: mockGetCartUseCase,
    addToCartUseCase: mockAddToCartUseCase,
    updateCartItemUseCase: mockUpdateCartItemUseCase,
    removeFromCartUseCase: mockRemoveFromCartUseCase,
  );

  group('CartBloc Tests', () {
    test('initial state is default CartState', () async {
      final bloc = createBloc();
      expect(bloc.state.status, equals(RequestStatus.initial));
      expect(bloc.state.cart, isNull);
      await bloc.close();
    });

    blocTest<CartBloc, CartState>(
      'emits [loading, success] when getCart succeeds with cart data',
      build: () {
        when(
          () => mockGetCartUseCase(),
        ).thenAnswer((_) async => const CartResponse(success: true, cart: sampleCart));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CartFetchRequested()),
      expect: () => [
        const CartState(status: RequestStatus.loading),
        const CartState(status: RequestStatus.success, cart: sampleCart),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [loading, failure] when getCart throws an exception',
      build: () {
        when(
          () => mockGetCartUseCase(),
        ).thenThrow(Exception('Network error'));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CartFetchRequested()),
      expect: () => [
        const CartState(status: RequestStatus.loading),
        predicate<CartState>(
          (state) =>
              state.status == RequestStatus.failure &&
              (state.errorMessage?.contains('Network error') ?? false),
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [actionLoading, actionSuccess, silentCartSuccess] when addToCart succeeds',
      build: () {
        when(
          () => mockAddToCartUseCase(
            propertyId: any(named: 'propertyId'),
            quantity: any(named: 'quantity'),
          ),
        ).thenAnswer(
          (_) async => const CartResponse(success: true, cart: sampleCart),
        );
        when(() => mockGetCartUseCase()).thenAnswer(
          (_) async => const CartResponse(success: true, cart: sampleCart),
        );
        return createBloc();
      },
      act: (bloc) => bloc.add(const CartItemAdded(propertyId: 1, quantity: 2)),
      expect: () => [
        const CartState(actionStatus: RequestStatus.loading),
        const CartState(
          actionStatus: RequestStatus.success,
          successType: CartSuccessType.added,
        ),
        const CartState(
          actionStatus: RequestStatus.success,
          status: RequestStatus.success,
          successType: CartSuccessType.added,
          cart: sampleCart,
        ),
      ],
    );
  });
}
