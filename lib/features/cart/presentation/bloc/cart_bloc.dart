import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/enums/request_status.dart';
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

  // Debouncing for quantity updates
  final Map<int, Timer> _debounceTimers = {};
  final Map<int, int> _pendingQuantities = {};

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
    if (!event.silent) {
      emit(state.copyWith(status: RequestStatus.loading));
    }
    try {
      final response = await getCartUseCase();
      var newCart = response.cart;

      if (newCart != null && _pendingQuantities.isNotEmpty) {
        var newTotal = 0.0;
        final updatedItems = newCart.items.map((item) {
          if (_pendingQuantities.containsKey(item.id)) {
            final pendingQ = _pendingQuantities[item.id]!;
            final basePrice = double.tryParse(item.price) ?? 0.0;
            var unitPrice = basePrice;
            if (item.offers != null && item.offers!.isNotEmpty) {
              final discountPercentage = item.offers!.first.discountPrice;
              unitPrice = basePrice * (1 - (discountPercentage / 100));
            }
            final newLineTotal = unitPrice * pendingQ;
            newTotal += newLineTotal;
            return item.copyWith(quantity: pendingQ, lineTotal: newLineTotal);
          }
          newTotal += item.lineTotal ?? 0.0;
          return item;
        }).toList();

        newCart = newCart.copyWith(items: updatedItems, total: newTotal);
      }

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
    _pendingQuantities[event.cartItemId] = event.quantity;

    if (state.cart != null) {
      var newTotal = 0.0;
      final updatedItems = state.cart!.items.map((item) {
        if (item.id == event.cartItemId) {
          final basePrice = double.tryParse(item.price) ?? 0.0;
          var unitPrice = basePrice;
          if (item.offers != null && item.offers!.isNotEmpty) {
            final discountPercentage = item.offers!.first.discountPrice;
            unitPrice = basePrice * (1 - (discountPercentage / 100));
          }
          final newLineTotal = unitPrice * event.quantity;
          newTotal += newLineTotal;
          return item.copyWith(
            quantity: event.quantity,
            lineTotal: newLineTotal,
          );
        }

        newTotal += item.lineTotal ?? 0.0;
        return item;
      }).toList();

      emit(
        state.copyWith(
          cart: state.cart!.copyWith(items: updatedItems, total: newTotal),
        ),
      );
    }

    _debounceTimers[event.cartItemId]?.cancel();
    final completer = Completer<void>();
    _debounceTimers[event.cartItemId] = Timer(
      const Duration(milliseconds: 500),
      () async {
        try {
          await updateCartItemUseCase(
            cartItemId: event.cartItemId,
            quantity: _pendingQuantities[event.cartItemId] ?? event.quantity,
          );
          _pendingQuantities.remove(event.cartItemId);
          _debounceTimers.remove(event.cartItemId);
          add(const CartFetchRequested(silent: true));
          emit(
            state.copyWith(
              actionStatus: RequestStatus.success,
              successType: CartSuccessType.updated,
            ),
          );
        } on Object catch (e) {
          _pendingQuantities.remove(event.cartItemId);
          _debounceTimers.remove(event.cartItemId);
          add(const CartFetchRequested(silent: true));
          emit(
            state.copyWith(
              actionStatus: RequestStatus.failure,
              errorMessage: e.toString(),
            ),
          );
        }
        completer.complete();
      },
    );
  }

  Future<void> _onItemRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
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

  void _onResetRequested(
    CartResetRequested event,
    Emitter<CartState> emit,
  ) {
    _pendingQuantities.clear();
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    emit(const CartState());
  }

  @override
  Future<void> close() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    return super.close();
  }
}
