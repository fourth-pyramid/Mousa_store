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
      Icon(Icons.star_rounded, size: 16.r, color: context.colors.secondary),
      SizedBox(width: 4.w),
      Text(
        rating.toStringAsFixed(1),
        style: context.typography.caption.copyWith(
          color: context.colors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (reviewCount != null) ...[
        SizedBox(width: 4.w),
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
