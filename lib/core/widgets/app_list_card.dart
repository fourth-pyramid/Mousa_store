import 'package:flutter/material.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: context.radius.cardBorder,
          boxShadow: isDark ? AppShadows.cardDark : AppShadows.card,
        ),
        child: ClipRRect(
          borderRadius: context.radius.cardBorder,
          child: SizedBox(
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Area
                AspectRatio(
                  aspectRatio: 1.0,
                  child: ColoredBox(
                    color: context.colors.surface,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AppImage(
                            image: image,
                            fit: imageFit,
                            errorWidget: (_, _, _) => Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 28.w,
                                color: context.colors.textMuted,
                              ),
                            ),
                          ),
                        ),
                        if (favoriteButton != null)
                          Positioned(
                            top: 6.h,
                            right: 6.w,
                            child: Container(
                              width: 28.r,
                              height: 28.r,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.88),
                                shape: BoxShape.circle,
                                boxShadow: AppShadows.subtle,
                              ),
                              child: favoriteButton,
                            ),
                          ),
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

                // Details Area
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.typography.bodySmall.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      if (numPrice != null) ...[
                        SizedBox(height: 4.h),
                        AppPrice(
                          price: numPrice,
                          originalPrice: numOldPrice,
                          currency: priceLabel ?? 'EGP',
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
