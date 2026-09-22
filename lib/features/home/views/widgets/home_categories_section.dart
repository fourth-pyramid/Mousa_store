import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/features/categories/models/category.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/views/category_items_view.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        previous.categoriesStatus != current.categoriesStatus ||
        previous.categories != current.categories,
    builder: (context, state) {
      if (state.categories.isEmpty &&
          state.categoriesStatus != RequestStatus.loading) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          AppSectionHeader(title: context.l10n.shop_by_category_text),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: state.categoriesStatus == RequestStatus.loading
                ? const _CategoriesLoadingSkeleton()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = (constraints.maxWidth / 160.w)
                          .floor()
                          .clamp(2, 4);

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 6.w,
                          mainAxisSpacing: 6.h,
                          childAspectRatio: 1.15,
                        ),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return _HomeCategoryCard(category: category);
                        },
                      );
                    },
                  ),
          ),
        ],
      );
    },
  );
}

class _CategoriesLoadingSkeleton extends StatelessWidget {
  const _CategoriesLoadingSkeleton();

  @override
  Widget build(BuildContext context) => Skeletonizer(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / 160.w).floor().clamp(
          2,
          4,
        );

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) => DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        );
      },
    ),
  );
}

class _HomeCategoryCard extends StatelessWidget {
  const _HomeCategoryCard({required this.category});

  final Category category;

  void _onTap(BuildContext context) {
    unawaited(
      navigateWithTransition<void>(
        context,
        CategoryItemsView(
          fetchType: ItemFetchType.category,
          categoryName: category.name,
          categoryId: category.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _onTap(context),
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: context.radius.lgBorder,
        boxShadow: AppShadows.card,
      ),
      child: ClipRRect(
        borderRadius: context.radius.lgBorder,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(
              image: category.imagePath ?? '',
              placeholder: (_, _) =>
                  ColoredBox(color: context.colors.surfaceStrong),
              errorWidget: (_, _, _) => ColoredBox(
                color: context.colors.surfaceStrong,
                child: Icon(
                  Icons.category_rounded,
                  size: 40.w,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            // Richer 3-stop gradient for readability
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.88),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Accent top edge highlight
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 3.h,
                color: AppColorTokens.accent.withValues(alpha: 0.85),
              ),
            ),
            PositionedDirectional(
              bottom: 10.h,
              start: 10.w,
              end: 10.w,
              child: Text(
                category.name,
                style: context.typography.h3.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
