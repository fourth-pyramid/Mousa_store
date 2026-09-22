import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_cubit.dart';
import 'package:mousa_store/features/brands/views/brands_view.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/views/category_items_view.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBrandsSection extends StatelessWidget {
  const HomeBrandsSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        previous.brandsStatus != current.brandsStatus ||
        previous.brands != current.brands,
    builder: (context, state) {
      if (state.brands.isEmpty && state.brandsStatus != RequestStatus.loading) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          AppSectionHeader(
            title: context.l10n.all_brands_text,
            actionLabel: context.l10n.view_all_text,
            onActionTap: () {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  BlocProvider(
                    create: (_) => getIt<BrandCubit>(),
                    child: const BrandsView(),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 88.h,
            child: state.brandsStatus == RequestStatus.loading
                ? const _BrandsLoadingSkeleton()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.brands.length,
                    separatorBuilder: (_, _) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final brand = state.brands[index];
                      return _HomeBrandCard(brand: brand);
                    },
                  ),
          ),
        ],
      );
    },
  );
}

class _BrandsLoadingSkeleton extends StatelessWidget {
  const _BrandsLoadingSkeleton();

  @override
  Widget build(BuildContext context) => Skeletonizer(
    child: ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, _) => SizedBox(width: 12.w),
      itemBuilder: (context, index) => SizedBox(
        width: 72.w,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: SizedBox(width: 64.w, height: 64.w),
            ),
            SizedBox(height: 6.h),
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surfaceStrong,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: SizedBox(width: 50.w, height: 12.h),
            ),
          ],
        ),
      ),
    ),
  );
}

class _HomeBrandCard extends StatelessWidget {
  const _HomeBrandCard({required this.brand});

  final Brand brand;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      unawaited(
        navigateWithTransition<void>(
          context,
          CategoryItemsView(
            fetchType: ItemFetchType.brand,
            brandName: brand.name,
            brandId: brand.id,
          ),
        ),
      );
    },
    child: SizedBox(
      width: 72.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: context.colors.border.withValues(alpha: 0.8),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colors.textPrimary.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AppImage(
              image: brand.imagePath,
              borderRadius: BorderRadius.circular(16.r),
              placeholder: (_, _) =>
                  ColoredBox(color: context.colors.surfaceStrong),
              errorWidget: (_, _, _) => ColoredBox(
                color: context.colors.surfaceStrong,
                child: Icon(
                  Icons.business_rounded,
                  size: 24.w,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            brand.name,
            style: context.typography.caption.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
