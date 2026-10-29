import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class ReviewSummaryCard extends StatelessWidget {
  const ReviewSummaryCard({
    required this.averageRating,
    required this.distribution,
    required this.totalReviews,
    super.key,
  });

  final double averageRating;
  final Map<int, int> distribution;
  final int totalReviews;

  @override
  Widget build(BuildContext context) => Card(
    color: context.colors.surface,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: context.radius.mdBorder),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [5, 4, 3].map((star) {
                final count = distribution[star] ?? 0;
                final percentage = totalReviews == 0
                    ? 0.0
                    : count / totalReviews;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: context.radius.xsBorder,
                          child: LinearProgressIndicator(
                            value: percentage,
                            minHeight: 8,
                            backgroundColor: context.colors.surfaceStrong,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        star.toString(),
                        style: context.typography.body.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(width: 24),

          Column(
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: context.typography.displayLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Icon(
                      index < averageRating.round()
                          ? Icons.star
                          : Icons.star_border,
                      color: context.colors.secondary,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
