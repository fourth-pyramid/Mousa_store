import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/show_login_dialog.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';

class ProductBottomActionBar extends StatelessWidget {
  const ProductBottomActionBar({
    required this.product,
    required this.selectedQuantity,
    required this.onQuantityChanged,
    this.selectedVariant,
    super.key,
  });

  final ProductDetail product;
  final int selectedQuantity;
  final ValueChanged<int> onQuantityChanged;
  final ProductVariant? selectedVariant;

  @override
  Widget build(BuildContext context) {
    final minQty = selectedVariant?.minQuantity ?? product.minQuantity;
    final maxQty = selectedVariant?.stock ?? product.displayStock;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(
            color: context.colors.border.withValues(alpha: 0.6),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              // ── Pill Quantity Stepper ──────────────────────────────
              _PillQuantityStepper(
                quantity: selectedQuantity,
                minQty: minQty,
                maxQty: maxQty,
                onChanged: onQuantityChanged,
              ),

              SizedBox(width: 12.w),

              // ── Add To Cart Action Button ──────────────────────────
              Expanded(
                child: _AddToCartButton(
                  product: product,
                  selectedVariant: selectedVariant,
                  effectiveQuantity: selectedQuantity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Pill Quantity Stepper ─────────────────────────────────────────────────────

class _PillQuantityStepper extends StatelessWidget {
  const _PillQuantityStepper({
    required this.quantity,
    required this.minQty,
    required this.maxQty,
    required this.onChanged,
  });

  final int quantity;
  final int minQty;
  final int maxQty;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final canDecrement = quantity > minQty;
    final canIncrement = quantity < maxQty;

    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: context.colors.border.withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement (−)
          _StepperButton(
            icon: Icons.remove_rounded,
            enabled: canDecrement,
            onTap: canDecrement ? () => onChanged(quantity - 1) : null,
          ),

          // Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: AnimatedSwitcher(
              duration: context.durations.fast,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                style: context.typography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
          ),

          // Increment (+)
          _StepperButton(
            icon: Icons.add_rounded,
            enabled: canIncrement,
            onTap: canIncrement ? () => onChanged(quantity + 1) : null,
            isHighlighted: true,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
    this.isHighlighted = false,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: context.durations.fast,
          width: 40.w,
          height: 40.h,
          margin: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: enabled && isHighlighted
                ? context.colors.accent
                : enabled
                    ? context.colors.surfaceStrong
                    : context.colors.surfaceStrong.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18.r,
            color: enabled && isHighlighted
                ? Colors.white
                : enabled
                    ? context.colors.textPrimary
                    : context.colors.textMuted,
          ),
        ),
      );
}

// ── Add To Cart Button ────────────────────────────────────────────────────────

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({
    required this.product,
    required this.selectedVariant,
    required this.effectiveQuantity,
  });

  final ProductDetail product;
  final ProductVariant? selectedVariant;
  final int effectiveQuantity;

  @override
  Widget build(BuildContext context) => BlocBuilder<CartCubit, CartState>(
        bloc: getIt<CartCubit>(),
        builder: (context, cartState) {
          final isLoading = cartState.actionStatus == RequestStatus.loading;
          final cart = cartState.cart;
          final targetPropertyId = selectedVariant?.id ?? product.id;
          final isInCart =
              cart?.items.any((item) => item.id == targetPropertyId) ?? false;

          return AppButton(
            isLoading: isLoading,
            height: 52.h,
            icon: Icon(
              isInCart
                  ? Icons.check_circle_outline_rounded
                  : Icons.shopping_bag_outlined,
              color:
                  isInCart ? context.colors.accent : context.colors.onPrimary,
              size: 20.r,
            ),
            text: isInCart
                ? context.l10n.product_added_text
                : context.l10n.add_to_cart_text,
            variant:
                isInCart ? AppButtonVariant.secondary : AppButtonVariant.primary,
            onPressed: isInCart
                ? null
                : () {
                    if (getIt<AuthService>().isLoggedIn) {
                      unawaited(
                        getIt<CartCubit>().addToCart(
                          propertyId: selectedVariant?.id ?? product.id,
                          quantity: effectiveQuantity,
                        ),
                      );
                    } else {
                      showLoginDialog(context);
                    }
                  },
          );
        },
      );
}
