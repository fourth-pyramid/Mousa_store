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
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: context.radius.mdBorder,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 12.h,
          width: 60.w,
          child: ColoredBox(color: context.colors.surfaceStrong),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 16.h,
          width: 120.w,
          child: ColoredBox(color: context.colors.surfaceStrong),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 16.h,
          width: 80.w,
          child: ColoredBox(color: context.colors.surfaceStrong),
        ),
      ],
    ),
  );
}

class AppSkeletonGrid extends StatelessWidget {
  const AppSkeletonGrid({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final crossAxisCount = (constraints.maxWidth / 160.w).floor().clamp(2, 4);

      return GridView.builder(
        padding: EdgeInsets.all(context.spacing.screenPadding),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: context.spacing.cardGap,
          crossAxisSpacing: context.spacing.cardGap,
          childAspectRatio:
              0.74, // ponytail: ratio 0.74 matches product grid layout
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => const AppSkeletonCard(),
      );
    },
  );
}
