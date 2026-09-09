import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_badge.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/app_price.dart';

class AppListCard extends StatelessWidget {
  const AppListCard({
    required this.title,
    required this.image,
    required this.onTap,
    this.price,
    this.oldPrice,
    this.discount,
    this.priceLabel,
    this.discountLabel,
    this.favoriteButton,
    this.description,
    this.imageFit = BoxFit.cover,
    super.key,
  });

  final String title;
  final String image;
  final VoidCallback onTap;
  final String? price;
  final String? oldPrice;
  final int? discount;
  final String? priceLabel;
  final String? discountLabel;
  final Widget? favoriteButton;
  final String? description;
  final BoxFit imageFit;

  @override
  Widget build(BuildContext context) {
    final numPrice = price != null ? num.tryParse(price!) : null;
    final numOldPrice = oldPrice != null ? num.tryParse(oldPrice!) : null;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: context.radius.mdBorder,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AppImage(
                        image: image,
                        fit: imageFit,
                        borderRadius: context.radius.mdBorder,
                        errorWidget: (_, _, _) => Center(
                          child: Icon(
                            Icons.sports_soccer,
                            size: 28.w,
                            color: context.colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    if (favoriteButton != null)
                      Positioned(top: 6.h, right: 6.w, child: favoriteButton!),
                    if (discount != null && discount! > 0)
                      Positioned(
                        top: 6.h,
                        left: 6.w,
                        child: AppBadge(
                          label: '-$discount%',
                          variant: AppBadgeVariant.accent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typography.body.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            if (numPrice != null)
              AppPrice(
                price: numPrice,
                originalPrice: numOldPrice,
                currency: priceLabel ?? 'EGP',
              ),
          ],
        ),
      ),
    );
  }
}
