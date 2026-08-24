import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/cart/models/cart_response.dart';
import 'package:mousa_store/features/cart/repositories/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends SafeCubit<CartState> {
  CartCubit(this.cartRepo) : super(const CartState());

  final CartRepo cartRepo;

  // Debouncing for quantity updates
  final Map<int, Timer> _debounceTimers = {};
  final Map<int, int> _pendingQuantities = {};

  Future<void> getCart({bool silent = false}) async {
    if (!silent) {
      emit(state.copyWith(status: RequestStatus.loading));
    }
    try {
      final response = await cartRepo.getCart();
      var newCart = response.cart;

      // Merge with pending quantities if any exist
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
      if (!silent) {
        emit(
          state.copyWith(
            status: RequestStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> addToCart({
    required int propertyId,
    required int quantity,
  }) async {
    emit(state.copyWith(actionStatus: RequestStatus.loading));
    try {
      await cartRepo.addToCart(propertyId: propertyId, quantity: quantity);
      // Even if response contains cart, fetch fresh data to ensure consistency and full details
      await getCart(silent: true);
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

  Future<void> updateQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    // 1. Store the target quantity as pending
    _pendingQuantities[cartItemId] = quantity;

    // 2. Optimistic Update UI immediately
    if (state.cart != null) {
      var newTotal = 0.0;
      final updatedItems = state.cart!.items.map((item) {
        if (item.id == cartItemId) {
          final basePrice = double.tryParse(item.price) ?? 0.0;
          var unitPrice = basePrice;
          if (item.offers != null && item.offers!.isNotEmpty) {
            final discountPercentage = item.offers!.first.discountPrice;
            unitPrice = basePrice * (1 - (discountPercentage / 100));
          }
          final newLineTotal = unitPrice * quantity;
          newTotal += newLineTotal;
          return item.copyWith(quantity: quantity, lineTotal: newLineTotal);
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

    // 3. Debounce the API call
    _debounceTimers[cartItemId]?.cancel();
    _debounceTimers[cartItemId] = Timer(
      const Duration(milliseconds: 500),
      () async {
        try {
          await cartRepo.updateCartItem(
            cartItemId: cartItemId,
            quantity: _pendingQuantities[cartItemId] ?? quantity,
          );

          // Remove from pending once synced
          _pendingQuantities.remove(cartItemId);
          _debounceTimers.remove(cartItemId);

          // Fetch fresh data silent to ensure full sync
          await getCart(silent: true);
          emit(
            state.copyWith(
              actionStatus: RequestStatus.success,
              successType: CartSuccessType.updated,
            ),
          );
        } on Object catch (e) {
          _pendingQuantities.remove(cartItemId);
          _debounceTimers.remove(cartItemId);
          // On error, we rely on getCart to eventually sync or user to retry
          // but for now, let's trigger a refresh to show reality
          await getCart(silent: true);
          emit(
            state.copyWith(
              actionStatus: RequestStatus.failure,
              errorMessage: e.toString(),
            ),
          );
        }
      },
    );
  }

  Future<void> removeItem({required int cartItemId}) async {
    // Store current cart for rollback
    final previousCart = state.cart;
    emit(state.copyWith(actionStatus: RequestStatus.loading));

    try {
      // Optimistically update UI
      if (previousCart != null) {
        var newTotal = 0.0;
        final updatedItems = previousCart.items
            .where((item) => item.id != cartItemId)
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

        if (updatedItems.isEmpty) {
          emit(
            state.copyWith(),
          ); // Or empty cart? null seems to show empty screen
          // Actually if items empty, usually cart is empty.
          // But here we assign new cart.
          // If strict null check in copyWith, we need to handle it.
          // state.copyWith(cart: ...) takes nullable Cart? so it is fine.
          // BUT wait, copyWith usually ignores null if variable is passed as null unless we wrap it.
          // My copyWith implementation: cart: cart ?? this.cart.
          // So passing null will NOT reset it to null. It will keep this.cart.
          // I need to fix copyWith to allow nullable update or pass a specific "clear" value.
          // For now, let's assume Cart with empty items is better than null for "empty state" if structure allows.
          // But `CartLoaded(this.cart)` used `Cart? cart`.
          // Let's fix copyWith logic in next step if needed.
          // For now, I'll pass a modified copy or empty list.
          emit(
            state.copyWith(
              cart: previousCart.copyWith(items: updatedItems, total: newTotal),
            ),
          );
        } else {
          emit(
            state.copyWith(
              cart: previousCart.copyWith(items: updatedItems, total: newTotal),
            ),
          );
        }
      }

      // Make API call
      await cartRepo.removeFromCart(cartItemId: cartItemId);
      emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          successType: CartSuccessType.removed,
        ),
      );
      // Refresh to confirm
      await getCart(silent: true);
    } on Object catch (e) {
      // Rollback on error
      emit(
        state.copyWith(
          cart: previousCart,
          actionStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void reset() {
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
    return super.close();
  }
}
