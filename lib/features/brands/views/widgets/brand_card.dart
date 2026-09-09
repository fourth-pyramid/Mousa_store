import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/views/category_items_view.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({required this.brand, super.key});

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
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colors.border.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: context.colors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: AppImage(
                image: brand.imagePath,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                placeholder: (_, _) =>
                    ColoredBox(color: context.colors.surfaceStrong),
                errorWidget: (_, _, _) => ColoredBox(
                  color: context.colors.surfaceStrong,
                  child: Icon(
                    Icons.business_rounded,
                    size: 36.w,
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Text(
              brand.name,
              style: context.typography.caption.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
