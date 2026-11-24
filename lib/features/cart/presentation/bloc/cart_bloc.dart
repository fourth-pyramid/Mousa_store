import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/utils/keyed_debouncer.dart';
import 'package:mousa_store/features/cart/data/models/cart_response.dart';
import 'package:mousa_store/features/cart/domain/usecases/cart_use_cases.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_event.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_state.dart';

export 'cart_event.dart';
export 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.updateCartItemUseCase,
    required this.removeFromCartUseCase,
  }) : super(const CartState()) {
    on<CartFetchRequested>(_onFetchRequested);
    on<CartItemAdded>(_onItemAdded);
    on<CartQuantityUpdated>(_onQuantityUpdated);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartResetRequested>(_onResetRequested);
  }

  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final UpdateCartItemUseCase updateCartItemUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;

  final _debouncer = KeyedDebouncer<int>();
  final Map<int, int> _pendingQuantities = {};
  final Map<int, int> _quantityVersions = {};
  Future<void> _quantityWrites = Future.value();
  int _generation = 0;

  Cart _withPending(Cart cart) {
    if (_pendingQuantities.isEmpty) return cart;
    final items = cart.items.map((item) {
      final quantity = _pendingQuantities[item.id];
      if (quantity == null) return item;
      final basePrice = double.tryParse(item.price) ?? 0.0;
      final discount = item.offers?.isNotEmpty ?? false
          ? item.offers!.first.discountPrice
          : 0.0;
      return item.copyWith(
        quantity: quantity,
        lineTotal: basePrice * (1 - discount / 100) * quantity,
      );
    }).toList();
    return cart.copyWith(
      items: items,
      total: items.fold<double>(
        0,
        (sum, item) =>
            sum +
            (item.lineTotal ??
                (double.tryParse(item.price) ?? 0) * item.quantity),
      ),
    );
  }

  Future<void> getCart({bool silent = false}) async {
    add(CartFetchRequested(silent: silent));
  }

  Future<void> addToCart({
    required int propertyId,
    required int quantity,
  }) async {
    add(CartItemAdded(propertyId: propertyId, quantity: quantity));
  }

  Future<void> updateQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    add(CartQuantityUpdated(cartItemId: cartItemId, quantity: quantity));
  }

  Future<void> removeItem({required int cartItemId}) async {
    add(CartItemRemoved(cartItemId: cartItemId));
  }

  void reset() {
    add(const CartResetRequested());
  }

  Future<void> _onFetchRequested(
    CartFetchRequested event,
    Emitter<CartState> emit,
  ) async {
    final generation = _generation;
    if (!event.silent) {
      emit(state.copyWith(status: RequestStatus.loading));
    }
    try {
      final response = await getCartUseCase();
      if (emit.isDone || generation != _generation) return;
      final newCart = response.cart == null
          ? null
          : _withPending(response.cart!);

      if (newCart == null) {
        emit(
          CartState(
            status: RequestStatus.success,
            actionStatus: state.actionStatus,
            successType: state.successType,
          ),
        );
      } else {
        emit(state.copyWith(status: RequestStatus.success, cart: newCart));
      }
    } on Object catch (e) {
      if (!event.silent) {
        emit(
          state.copyWith(
            status: RequestStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> _onItemAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(actionStatus: RequestStatus.loading));
    try {
      await addToCartUseCase(
        propertyId: event.propertyId,
        quantity: event.quantity,
      );
      add(const CartFetchRequested(silent: true));
      emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          successType: CartSuccessType.added,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          actionStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onQuantityUpdated(
    CartQuantityUpdated event,
    Emitter<CartState> emit,
  ) async {
    final id = event.cartItemId;
    final generation = _generation;
    final version = (_quantityVersions[id] ?? 0) + 1;
    _quantityVersions[id] = version;
    _pendingQuantities[id] = event.quantity;
    if (state.cart != null) {
      emit(state.copyWith(cart: _withPending(state.cart!)));
    }

    if (!await _debouncer.wait(id, const Duration(milliseconds: 500))) return;
    if (emit.isDone || generation != _generation) return;
    // Serialize requests, not debounce windows. This preserves independent
    // item edits and prevents older whole-cart responses overwriting newer ones.
    final previousWrite = _quantityWrites;
    final completed = Completer<void>();
    _quantityWrites = completed.future;
    try {
      await previousWrite;
      if (emit.isDone ||
          generation != _generation ||
          _quantityVersions[id] != version) {
        return;
      }
      final response = await updateCartItemUseCase(
        cartItemId: id,
        quantity: event.quantity,
      );
      if (emit.isDone || generation != _generation) return;
      if (!response.success) {
        throw StateError(response.message ?? 'Cart update failed');
      }
      final cart = response.cart ?? (await getCartUseCase()).cart;
      if (emit.isDone || generation != _generation) return;
      if (_quantityVersions[id] == version) _pendingQuantities.remove(id);
      if (cart != null) {
        emit(
          state.copyWith(
            cart: _withPending(cart),
            actionStatus: RequestStatus.success,
            successType: CartSuccessType.updated,
          ),
        );
      }
    } on Object catch (e) {
      if (emit.isDone || generation != _generation) return;
      if (_quantityVersions[id] == version) _pendingQuantities.remove(id);
      // Recover server prices after failure, keeping other pending edits visible.
      try {
        final cart = (await getCartUseCase()).cart;
        if (emit.isDone || generation != _generation) return;
        if (cart != null) emit(state.copyWith(cart: _withPending(cart)));
      } on Object catch (_) {
        /* Preserve the last visible cart if offline. */
      }
      if (!emit.isDone && generation == _generation) {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    } finally {
      completed.complete();
    }
  }

  Future<void> _onItemRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    _debouncer.cancel(event.cartItemId);
    _pendingQuantities.remove(event.cartItemId);
    _quantityVersions[event.cartItemId] =
        (_quantityVersions[event.cartItemId] ?? 0) + 1;
    await _quantityWrites;
    if (emit.isDone) return;
    final previousCart = state.cart;
    emit(state.copyWith(actionStatus: RequestStatus.loading));

    try {
      if (previousCart != null) {
        var newTotal = 0.0;
        final updatedItems = previousCart.items
            .where((item) => item.id != event.cartItemId)
            .map((item) {
              if (item.lineTotal != null) {
                newTotal += item.lineTotal!;
              } else {
                final basePrice = double.tryParse(item.price) ?? 0.0;
                var unitPrice = basePrice;
                if (item.offers != null && item.offers!.isNotEmpty) {
                  final discountPercentage = item.offers!.first.discountPrice;
                  unitPrice = basePrice * (1 - (discountPercentage / 100));
                }
                newTotal += unitPrice * item.quantity;
              }
              return item;
            })
            .toList();

        emit(
          state.copyWith(
            cart: previousCart.copyWith(items: updatedItems, total: newTotal),
          ),
        );
      }

      await removeFromCartUseCase(cartItemId: event.cartItemId);
      emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          successType: CartSuccessType.removed,
        ),
      );
      add(const CartFetchRequested(silent: true));
    } on Object catch (e) {
      emit(
        state.copyWith(
          cart: previousCart,
          actionStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onResetRequested(CartResetRequested event, Emitter<CartState> emit) {
    _generation++;
    _pendingQuantities.clear();
    _quantityVersions.clear();
    _debouncer.cancelAll();
    emit(const CartState());
  }

  @override
  Future<void> close() {
    _generation++;
    _debouncer.cancelAll();
    return super.close();
  }
}
