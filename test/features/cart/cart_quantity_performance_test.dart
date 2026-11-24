import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/data/models/cart_response.dart';
import 'package:mousa_store/features/cart/domain/usecases/cart_use_cases.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';

class _Get extends Mock implements GetCartUseCase {}

class _Add extends Mock implements AddToCartUseCase {}

class _Update extends Mock implements UpdateCartItemUseCase {}

class _Remove extends Mock implements RemoveFromCartUseCase {}

void main() {
  const item = CartItem(
    id: 1,
    name: 'one',
    desc: '',
    price: '10',
    imagePath: '',
    imagesPath: [],
    quantity: 1,
    lineTotal: 10,
  );
  const second = CartItem(
    id: 2,
    name: 'two',
    desc: '',
    price: '10',
    imagePath: '',
    imagesPath: [],
    quantity: 1,
    lineTotal: 10,
  );
  const cart = Cart(id: 1, userId: 1, total: 20, items: [item, second]);
  late _Get get;
  late _Update update;
  late CartBloc bloc;
  setUp(() async {
    get = _Get();
    update = _Update();
    when(() => get())
        .thenAnswer((_) async => const CartResponse(success: true, cart: cart));
    bloc = CartBloc(
      getCartUseCase: get,
      addToCartUseCase: _Add(),
      updateCartItemUseCase: update,
      removeFromCartUseCase: _Remove(),
    )
    ..add(const CartFetchRequested());
    await bloc.stream.firstWhere((s) => s.status == RequestStatus.success);
    clearInteractions(get);
  });
  tearDown(() async {
    if (!bloc.isClosed) await bloc.close();
  });

  test(
    'rapid same-item edits send only the latest and use server totals',
    () async {
      final authoritative = cart.copyWith(
        total: 45,
        items: [item.copyWith(quantity: 3, lineTotal: 35), second],
      );
      when(() => update(cartItemId: 1, quantity: 3)).thenAnswer(
        (_) async => CartResponse(success: true, cart: authoritative),
      );
      bloc..add(const CartQuantityUpdated(cartItemId: 1, quantity: 2))
      ..add(const CartQuantityUpdated(cartItemId: 1, quantity: 3));
      await bloc.stream
          .firstWhere((s) => s.actionStatus == RequestStatus.success)
          .timeout(const Duration(seconds: 3));
      verify(() => update(cartItemId: 1, quantity: 3)).called(1);
      verifyNever(() => update(cartItemId: 1, quantity: 2));
      verifyNever(() => get());
      expect(bloc.state.cart!.total, 45);
    },
  );
  test('different items both update and requests do not overlap', () async {
    final first = Completer<CartResponse>();
    final secondStarted = Completer<void>();
    when(() => update(cartItemId: 1, quantity: 2))
        .thenAnswer((_) => first.future);
    when(() => update(cartItemId: 2, quantity: 3)).thenAnswer((_) async {
      secondStarted.complete();
      return CartResponse(
        success: true,
        cart: cart.copyWith(
          total: 50,
          items: [
            item.copyWith(quantity: 2, lineTotal: 20),
            second.copyWith(quantity: 3, lineTotal: 30),
          ],
        ),
      );
    });
    bloc..add(const CartQuantityUpdated(cartItemId: 1, quantity: 2))
    ..add(const CartQuantityUpdated(cartItemId: 2, quantity: 3));
    await Future<void>.delayed(const Duration(milliseconds: 600));
    expect(secondStarted.isCompleted, isFalse);
    first.complete(
      CartResponse(
        success: true,
        cart: cart.copyWith(
          total: 30,
          items: [item.copyWith(quantity: 2, lineTotal: 20), second],
        ),
      ),
    );
    await secondStarted.future.timeout(const Duration(seconds: 3));
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.cart!.items.map((i) => i.quantity), [2, 3]);
    expect(bloc.state.cart!.total, 50);
    verifyNever(() => get());
  });
  test('missing response cart falls back to one authoritative fetch', () async {
    when(() => update(cartItemId: 1, quantity: 2))
        .thenAnswer((_) async => const CartResponse(success: true));
    bloc.add(const CartQuantityUpdated(cartItemId: 1, quantity: 2));
    await bloc.stream
        .firstWhere((s) => s.actionStatus == RequestStatus.success)
        .timeout(const Duration(seconds: 3));
    verify(() => get()).called(1);
  });
  test('reset cancels pending debounce and late emissions', () async {
    bloc.add(const CartQuantityUpdated(cartItemId: 1, quantity: 2));
    await Future<void>.delayed(Duration.zero);
    bloc.add(const CartResetRequested());
    await Future<void>.delayed(const Duration(milliseconds: 600));
    expect(bloc.state.cart, isNull);
    verifyNever(() => update(cartItemId: 1, quantity: 2));
  });
  test('close cancels an awaited debounce without hanging', () async {
    bloc.add(const CartQuantityUpdated(cartItemId: 1, quantity: 2));
    await Future<void>.delayed(Duration.zero);
    await bloc.close().timeout(const Duration(seconds: 1));
    verifyNever(() => update(cartItemId: 1, quantity: 2));
  });
}
