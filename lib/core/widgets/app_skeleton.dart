import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonCard extends StatelessWidget {
  const AppSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) => Skeletonizer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: context.radius.mdBorder,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 12, width: 60, color: context.colors.surfaceStrong),
        const SizedBox(height: 4),
        Container(height: 16, width: 120, color: context.colors.surfaceStrong),
        const SizedBox(height: 4),
        Container(height: 16, width: 80, color: context.colors.surfaceStrong),
      ],
    ),
  );
}

class AppSkeletonGrid extends StatelessWidget {
  const AppSkeletonGrid({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: EdgeInsets.all(context.spacing.screenPadding),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: context.spacing.cardGap,
      crossAxisSpacing: context.spacing.cardGap,
      childAspectRatio:
          0.74, // ponytail: ratio 0.74 matches product grid layout
    ),
    itemCount: itemCount,
    itemBuilder: (context, index) => const AppSkeletonCard(),
  );
}
