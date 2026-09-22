import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_badge.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/app_price.dart';

class AppGridCard extends StatelessWidget {
  const AppGridCard({
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Area
              Expanded(
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
                              size: 36.w,
                              color: context.colors.textMuted,
                            ),
                          ),
                        ),
                      ),
                      // Bottom gradient scrim for readability
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 36.h,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.08),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Favorite button top-right
                      if (favoriteButton != null)
                        Positioned(
                          top: 6.h,
                          right: 6.w,
                          child: _GlassFavoriteWrapper(child: favoriteButton!),
                        ),
                      // Discount badge top-left
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
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (description != null) ...[
                      Text(
                        description!.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.typography.overline.copyWith(
                          color: context.colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typography.body.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (numPrice != null) ...[
                      SizedBox(height: 4.h),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: AppPrice(
                          price: numPrice,
                          originalPrice: numOldPrice,
                          currency: priceLabel ?? 'EGP',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Glass morphic circle wrapper for the favorite button
class _GlassFavoriteWrapper extends StatelessWidget {
  const _GlassFavoriteWrapper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: 32.r,
    height: 32.r,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.88),
      shape: BoxShape.circle,
      boxShadow: AppShadows.subtle,
    ),
    child: child,
  );
}
