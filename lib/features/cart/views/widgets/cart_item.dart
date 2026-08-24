import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    required this.name,
    required this.specs,
    required this.image,
    required this.price,
    required this.quantity,
    required this.cartItemId,
    required this.minQuantity,
    required this.stock,
    this.offers,
    this.attributes,
    super.key,
  });
  final String name;
  final String specs;
  final String image;
  final double price;
  final int quantity;
  final int cartItemId;
  final int minQuantity;
  final int stock;
  final List<Offer>? offers;
  final Map<String, String>? attributes;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late ValueNotifier<int> _quantityNotifier;
  late double _unitPrice;

  @override
  void initState() {
    super.initState();
    _quantityNotifier = ValueNotifier(widget.quantity);
    _unitPrice = _calculateUnitPrice();
  }

  @override
  void didUpdateWidget(covariant CartItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity) {
      _quantityNotifier.value = widget.quantity;
    }
    _unitPrice = _calculateUnitPrice();
  }

  double _calculateUnitPrice() {
    if (widget.offers != null && widget.offers!.isNotEmpty) {
      final discountPercentage = widget.offers!.first.discountPrice;
      return widget.price * (1 - (discountPercentage / 100));
    }
    return widget.price;
  }

  @override
  void dispose() {
    _quantityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? formattedAttributes;
    if (widget.attributes != null && widget.attributes!.isNotEmpty) {
      formattedAttributes = widget.attributes!.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    }

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 6.0.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppImage(
                image: widget.image,
                height: 95.h,
                width: 90.w,
                borderRadius: BorderRadius.circular(12.r),
                errorWidget: (context, url, error) => Container(
                  height: 95.h,
                  width: 90.w,
                  color: context.colors.surface,
                  child: Icon(Icons.sports_soccer, size: 24.w, color: context.colors.textSecondary),
                ),
              ),
              if (widget.offers != null && widget.offers!.isNotEmpty)
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(12.r),
                        bottomStart: Radius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      '${widget.offers!.first.discountPrice.toInt()}%-',
                      style: context.typography.caption.copyWith(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.typography.h3),

                if (formattedAttributes != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 2.0.h),
                    child: Text(
                      formattedAttributes,
                      style: context.typography.bodySmall.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 4.0.h),
                  child: Text(
                    widget.specs,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.bodySmall,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 34.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: context.colors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ValueListenableBuilder<int>(
                            valueListenable: _quantityNotifier,
                            builder: (context, q, _) => IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 16.r,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: q >= widget.stock
                                  ? null
                                  : () {
                                      final newQ = q + 1;
                                      _quantityNotifier.value = newQ;
                                      unawaited(
                                        context.read<CartCubit>().updateQuantity(
                                          cartItemId: widget.cartItemId,
                                          quantity: newQ,
                                        ),
                                      );
                                    },
                            ),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: _quantityNotifier,
                            builder: (context, q, _) => Text(q.toString(), style: context.typography.bodySmall),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: _quantityNotifier,
                            builder: (context, q, _) => IconButton(
                              icon: const Icon(Icons.remove),
                              iconSize: 16.r,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: q <= widget.minQuantity
                                  ? null
                                  : () {
                                      final newQ = q - 1;
                                      _quantityNotifier.value = newQ;
                                      unawaited(
                                        context.read<CartCubit>().updateQuantity(
                                          cartItemId: widget.cartItemId,
                                          quantity: newQ,
                                        ),
                                      );
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsetsDirectional.only(top: 8.0.h),
                  child: Wrap(
                    // ponytail: use Wrap to prevent price text overflow
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.w,
                    runSpacing: 2.h,
                    children: [
                      Text(
                        '${context.l10n.piece_price_text}: ${_unitPrice.toStringAsFixed(2)} ${context.l10n.egp_text}',
                        style: context.typography.bodySmall.copyWith(color: context.colors.textSecondary),
                      ),
                      if (widget.offers != null && widget.offers!.isNotEmpty)
                        Text(
                          '${widget.price.toStringAsFixed(2)} ${context.l10n.egp_text}',
                          style: context.typography.bodySmall.copyWith(
                            color: context.colors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),

                ValueListenableBuilder<int>(
                  valueListenable: _quantityNotifier,
                  builder: (context, q, _) => Text(
                    '${context.l10n.total_text}: ${(_unitPrice * q).toStringAsFixed(2)} ${context.l10n.egp_text}',
                    style: context.typography.h3.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
