import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_shimmer.dart';

class AppSkeletonCard extends StatelessWidget {
  const AppSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: context.radius.mdBorder,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.surfaceStrong,
                borderRadius: context.radius.smBorder,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            width: 60,
            decoration: BoxDecoration(
              color: context.colors.surfaceStrong,
              borderRadius: context.radius.xsBorder,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 16,
            width: 120,
            decoration: BoxDecoration(
              color: context.colors.surfaceStrong,
              borderRadius: context.radius.xsBorder,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 16,
            width: 80,
            decoration: BoxDecoration(
              color: context.colors.surfaceStrong,
              borderRadius: context.radius.xsBorder,
            ),
          ),
        ],
      ),
    ),
  );
}

class AppSkeletonGrid extends StatelessWidget {
  const AppSkeletonGrid({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final crossAxisCount = (constraints.maxWidth / 160).floor().clamp(2, 4);

      return GridView.builder(
        padding: EdgeInsets.all(context.spacing.screenPadding),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: context.spacing.cardGap,
          crossAxisSpacing: context.spacing.cardGap,
          childAspectRatio: 0.74,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => const AppSkeletonCard(),
      );
    },
  );
}
