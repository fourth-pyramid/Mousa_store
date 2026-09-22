import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/brand.dart';

class FilterBrandSection extends StatelessWidget {
  const FilterBrandSection({
    required this.brands,
    required this.selectedBrand,
    required this.onBrandSelected,
    super.key,
  });

  final List<Brand> brands;
  final Brand? selectedBrand;
  final ValueChanged<Brand?> onBrandSelected;

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: Row(
            children: [
              Text(
                context.l10n.brand_text,
                style: context.typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (selectedBrand != null) ...[
                SizedBox(width: 8.w),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    borderRadius: context.radius.pillBorder,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    child: Text(
                      '1',
                      style: context.typography.caption.copyWith(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          height: 48.h,
          child: ListView.separated(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: brands.length + 1,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isAllSelected = selectedBrand == null;
                return _AllBrandsChip(
                  isSelected: isAllSelected,
                  onTap: () => onBrandSelected(null),
                );
              }

              final brand = brands[index - 1];
              final isSelected = selectedBrand?.id == brand.id;

              return _BrandChip(
                brand: brand,
                isSelected: isSelected,
                onTap: () => onBrandSelected(isSelected ? null : brand),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AllBrandsChip extends StatelessWidget {
  const _AllBrandsChip({required this.isSelected, required this.onTap});

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: context.durations.fast,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.surfaceStrong.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.grid_view_rounded,
              size: 16.r,
              color: isSelected
                  ? context.colors.onPrimary
                  : context.colors.textSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              context.l10n.all_brands_text,
              style: context.typography.bodySmall.copyWith(
                color: isSelected
                    ? context.colors.onPrimary
                    : context.colors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({
    required this.brand,
    required this.isSelected,
    required this.onTap,
  });

  final Brand brand;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: context.durations.fast,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.surfaceStrong.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (brand.imagePath != null && brand.imagePath!.isNotEmpty) ...[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.background,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.r),
                  child: AppImage(
                    image: brand.imagePath!,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    errorWidget: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              brand.name ?? '',
              style: context.typography.bodySmall.copyWith(
                color: isSelected
                    ? context.colors.onPrimary
                    : context.colors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.check_rounded,
                size: 16.r,
                color: context.colors.onPrimary,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
