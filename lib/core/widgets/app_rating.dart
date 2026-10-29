import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppRating extends StatelessWidget {
  const AppRating({required this.rating, super.key, this.reviewCount});

  final double rating;
  final int? reviewCount;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star_rounded, size: 16, color: context.colors.secondary),
      const SizedBox(width: 4),
      Text(
        rating.toStringAsFixed(1),
        style: context.typography.caption.copyWith(
          color: context.colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (reviewCount != null) ...[
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: context.typography.caption.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    ],
  );
}
