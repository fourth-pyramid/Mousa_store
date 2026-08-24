import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/models/cart_response.dart';
import 'package:mousa_store/features/cart/repositories/cart_repo.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';

class MockCartRepo extends Mock implements CartRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCartRepo mockCartRepo;

  setUp(() {
    mockCartRepo = MockCartRepo();
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

  group('CartCubit Tests', () {
    test('initial state is default CartState', () async {
      final cubit = CartCubit(mockCartRepo);
      expect(cubit.state.status, equals(RequestStatus.initial));
      expect(cubit.state.cart, isNull);
      await cubit.close();
    });

    blocTest<CartCubit, CartState>(
      'emits [loading, success] when getCart succeeds with cart data',
      build: () {
        when(() => mockCartRepo.getCart()).thenAnswer(
          (_) async => const CartResponse(success: true, cart: sampleCart),
        );
        return CartCubit(mockCartRepo);
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [
        const CartState(status: RequestStatus.loading),
        const CartState(status: RequestStatus.success, cart: sampleCart),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, failure] when getCart throws an exception',
      build: () {
        when(() => mockCartRepo.getCart()).thenThrow(Exception('Network error'));
        return CartCubit(mockCartRepo);
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [
        const CartState(status: RequestStatus.loading),
        predicate<CartState>(
          (state) =>
              state.status == RequestStatus.failure &&
              state.errorMessage != null &&
              state.errorMessage!.contains('Network error'),
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [loading, success] when addToCart succeeds',
      build: () {
        when(
          () => mockCartRepo.addToCart(
            propertyId: any(named: 'propertyId'),
            quantity: any(named: 'quantity'),
          ),
        ).thenAnswer(
          (_) async => const CartResponse(success: true, cart: sampleCart),
        );
        when(() => mockCartRepo.getCart()).thenAnswer(
          (_) async => const CartResponse(success: true, cart: sampleCart),
        );
        return CartCubit(mockCartRepo);
      },
      act: (cubit) => cubit.addToCart(propertyId: 1, quantity: 2),
      expect: () => [
        const CartState(actionStatus: RequestStatus.loading),
        const CartState(
          actionStatus: RequestStatus.loading,
          status: RequestStatus.success,
          cart: sampleCart,
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
