import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/show_login_dialog.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/view/widgets/quantity_selector.dart';

class ProductBottomActionBar extends StatefulWidget {
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
  State<ProductBottomActionBar> createState() => _ProductBottomActionBarState();
}

class _ProductBottomActionBarState extends State<ProductBottomActionBar> {
  final ValueNotifier<bool> _showQuantitySelectorNotifier = ValueNotifier<bool>(
    false,
  );

  @override
  void dispose() {
    _showQuantitySelectorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minQty =
        widget.selectedVariant?.minQuantity ?? widget.product.minQuantity;
    final maxQty = widget.selectedVariant?.stock ?? widget.product.displayStock;
    final effectiveQuantity = widget.selectedQuantity;

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.colors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SafeArea(
        top: false,
        child: ValueListenableBuilder<bool>(
          valueListenable: _showQuantitySelectorNotifier,
          builder: (context, showQuantitySelector, _) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showQuantitySelector) ...[
                QuantitySelector(
                  selectedQuantity: effectiveQuantity,
                  minQuantity: minQty,
                  maxQuantity: maxQty,
                  onQuantityChanged: widget.onQuantityChanged,
                ),
                SizedBox(height: 12.h),
              ],
              Row(
                children: [
                  Expanded(
                    child: _AddToCartButton(
                      product: widget.product,
                      selectedVariant: widget.selectedVariant,
                      effectiveQuantity: effectiveQuantity,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      _showQuantitySelectorNotifier.value =
                          !_showQuantitySelectorNotifier.value;
                    },
                    child: Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceStrong,
                        borderRadius: context.radius.smBorder,
                        border: Border.all(color: context.colors.border),
                      ),
                      child: Center(
                        child: Text(
                          'QTY: $effectiveQuantity',
                          style: context.typography.labelLarge.copyWith(
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        text: isInCart
            ? context.l10n.product_added_text
            : context.l10n.add_to_cart_text,
        variant: isInCart
            ? AppButtonVariant.secondary
            : AppButtonVariant.primary,
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
