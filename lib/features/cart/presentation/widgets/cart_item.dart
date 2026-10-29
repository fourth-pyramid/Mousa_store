import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/models/offer.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';

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
      formattedAttributes = widget.attributes!.entries
          .map((e) => '${e.key}: ${e.value}')
          .join(', ');
    }

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6.0,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppImage(
                image: widget.image,
                height: 95,
                width: 90,
                borderRadius: BorderRadius.circular(12),
                errorWidget: (context, url, error) => SizedBox(
                  height: 95,
                  width: 90,
                  child: ColoredBox(
                    color: context.colors.surface,
                    child: Icon(
                      Icons.sports_soccer,
                      size: 24,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
              ),
              if (widget.offers != null && widget.offers!.isNotEmpty)
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(12),
                        bottomStart: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Text(
                        '${widget.offers!.first.discountPrice.toInt()}%-',
                        style: context.typography.caption.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.h3,
                ),

                if (formattedAttributes != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 2.0),
                    child: Text(
                      formattedAttributes,
                      style: context.typography.bodySmall.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 4.0),
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
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: context.radius.smBorder,
                        border: Border.all(color: context.colors.border),
                      ),
                      child: SizedBox(
                        height: 34,
                        child: ValueListenableBuilder<int>(
                          valueListenable: _quantityNotifier,
                          builder: (context, q, _) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add),
                                iconSize: 16,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 34,
                                ),
                                style: IconButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: const Size(32, 34),
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: q >= widget.stock
                                    ? null
                                    : () {
                                        final newQ = q + 1;
                                        _quantityNotifier.value = newQ;
                                        unawaited(
                                          context
                                              .read<CartBloc>()
                                              .updateQuantity(
                                                cartItemId: widget.cartItemId,
                                                quantity: newQ,
                                              ),
                                        );
                                      },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 24,
                                  ),
                                  child: Center(
                                    child: Text(
                                      q.toString(),
                                      style: context.typography.bodySmall
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                iconSize: 16,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 34,
                                ),
                                style: IconButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: const Size(32, 34),
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: q <= widget.minQuantity
                                    ? null
                                    : () {
                                        final newQ = q - 1;
                                        _quantityNotifier.value = newQ;
                                        unawaited(
                                          context
                                              .read<CartBloc>()
                                              .updateQuantity(
                                                cartItemId: widget.cartItemId,
                                                quantity: newQ,
                                              ),
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 8.0),
                  child: Wrap(
                    // ponytail: use Wrap to prevent price text overflow
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 2,
                    children: [
                      Text(
                        '${context.l10n.piece_price_text}: ${_unitPrice.toStringAsFixed(2)} ${context.l10n.egp_text}',
                        style: context.typography.bodySmall.copyWith(
                          color: context.colors.textSecondary,
                        ),
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
                    style: context.typography.h3.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
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
