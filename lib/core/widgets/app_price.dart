import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppPrice extends StatelessWidget {
  const AppPrice({
    required this.price,
    super.key,
    this.originalPrice,
    this.currency = 'EGP',
    this.isLarge = false,
  });

  final num price;
  final num? originalPrice;
  final String currency;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final textPrimary = context.colors.textPrimary;
    final textMuted = context.colors.textSecondary;

    final hasDiscount = originalPrice != null && originalPrice! > price;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$currency ${price.toStringAsFixed(0)}',
          style: isLarge
              ? context.typography.titleLarge.copyWith(
                  color: textPrimary,
                  fontWeight: FontWeight.bold,
                )
              : context.typography.body.copyWith(
                  color: textPrimary,
                  fontWeight: FontWeight.bold,
                ),
        ),
        if (hasDiscount) ...[
          SizedBox(width: 8.w),
          Text(
            '$currency ${originalPrice!.toStringAsFixed(0)}',
            style:
                (isLarge
                        ? context.typography.body
                        : context.typography.bodySmall)
                    .copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: textMuted,
                    ),
          ),
        ],
      ],
    );
  }
}
