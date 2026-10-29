import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/core/widgets/app_shimmer.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/brands/presentation/bloc/brand_bloc.dart';
import 'package:mousa_store/features/brands/presentation/pages/brands_view.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/presentation/pages/category_items_view.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_state.dart';

class HomeBrandsSection extends StatelessWidget {
  const HomeBrandsSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
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
          const SizedBox(height: 20),
          AppSectionHeader(
            title: context.l10n.all_brands_text,
            actionLabel: context.l10n.view_all_text,
            onActionTap: () {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  BlocProvider(
                    create: (_) => getIt<BrandBloc>(),
                    child: const BrandsView(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 88,
            child: state.brandsStatus == RequestStatus.loading
                ? const _BrandsLoadingSkeleton()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.brands.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
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
  Widget build(BuildContext context) => AppShimmer(
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(width: 12),
      itemBuilder: (context, index) => SizedBox(
        width: 72,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const SizedBox(width: 64, height: 64),
            ),
            const SizedBox(height: 6),
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surfaceStrong,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const SizedBox(width: 50, height: 12),
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
      width: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(18),
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
              borderRadius: BorderRadius.circular(16),
              placeholder: (_, _) =>
                  ColoredBox(color: context.colors.surfaceStrong),
              errorWidget: (_, _, _) => ColoredBox(
                color: context.colors.surfaceStrong,
                child: Icon(
                  Icons.business_rounded,
                  size: 24,
                  color: context.colors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            brand.name,
            style: context.typography.caption.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 11,
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
