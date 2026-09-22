import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/view/widgets/product_image_carousel.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    required this.product,
    this.selectedVariant,
    super.key,
  });

  final ProductDetail product;
  final ProductVariant? selectedVariant;

  @override
  Widget build(BuildContext context) {
    final images = _getImages();

    final displayPrice = selectedVariant?.price ?? product.displayPrice;
    final price = double.tryParse(displayPrice) ?? 0;
    final activeOffer = selectedVariant?.offers?.firstOrNull;

    double? discountedPrice;
    int? discountPercent;
    if (activeOffer?.disscountPrice != null &&
        activeOffer!.disscountPrice > 0) {
      discountPercent = activeOffer.disscountPrice.toInt();
      discountedPrice = price - (price * activeOffer.disscountPrice / 100);
    }

    final savedAmount = (discountedPrice != null) ? (price - discountedPrice) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Product Hero Image Carousel (edge-to-edge) ─────────────
        ProductImageCarousel(
          images: images,
          discountPercentage: discountPercent,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Brand Badge + Rating Row ───────────────────────────
              Row(
                children: [
                  if (product.brand?.name.isNotEmpty ?? false)
                    _BrandBadge(name: product.brand!.name),
                  const Spacer(),
                  if (product.averageRating > 0)
                    _RatingChip(
                      rating: product.averageRating,
                      reviewsCount: product.reviewsCount,
                    ),
                ],
              ),

              SizedBox(height: 12.h),

              // ── Product Title ──────────────────────────────────────
              Text(
                product.name,
                style: context.typography.h1.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.35,
                  color: context.colors.textPrimary,
                ),
              ),

              SizedBox(height: 16.h),

              // ── Premium Price Card ─────────────────────────────────
              _PriceCard(
                price: price,
                discountedPrice: discountedPrice,
                savedAmount: savedAmount,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> _getImages() {
    final mainImage = selectedVariant?.imagePath ?? product.displayImage;
    final variantImages = selectedVariant?.imagesPath ?? product.imagesPath;

    return [if (mainImage.isNotEmpty) mainImage, ...variantImages];
  }
}

// ── Brand Badge ──────────────────────────────────────────────────────────────

class _BrandBadge extends StatelessWidget {
  const _BrandBadge({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colors.accent.withValues(alpha: 0.12),
              context.colors.accent.withValues(alpha: 0.06),
            ],
          ),
          borderRadius: context.radius.pillBorder,
          border: Border.all(
            color: context.colors.accent.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified_rounded,
              size: 13.r,
              color: context.colors.accent,
            ),
            SizedBox(width: 4.w),
            Text(
              name,
              style: context.typography.label.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.accent,
              ),
            ),
          ],
        ),
      );
}

// ── Rating Chip ──────────────────────────────────────────────────────────────

class _RatingChip extends StatelessWidget {
  const _RatingChip({required this.rating, required this.reviewsCount});

  final double rating;
  final int reviewsCount;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7),
          borderRadius: context.radius.pillBorder,
          border: Border.all(color: const Color(0xFFFFCC02).withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rounded,
              size: 14.r,
              color: const Color(0xFFFFCC02),
            ),
            SizedBox(width: 3.w),
            Text(
              rating.toStringAsFixed(1),
              style: context.typography.label.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7A5A00),
              ),
            ),
            if (reviewsCount > 0) ...[
              SizedBox(width: 3.w),
              Text(
                '($reviewsCount)',
                style: context.typography.caption.copyWith(
                  color: const Color(0xFF9E7B00),
                ),
              ),
            ],
          ],
        ),
      );
}

// ── Price Card ───────────────────────────────────────────────────────────────

class _PriceCard extends StatelessWidget {
  const _PriceCard({
    required this.price,
    required this.discountedPrice,
    required this.savedAmount,
  });

  final double price;
  final double? discountedPrice;
  final double savedAmount;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: context.radius.mdBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: context.radius.mdBorder,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left accent bar
                Container(
                  width: 4.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.colors.accent,
                        context.colors.accent.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),

                // Price content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Main price row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    (discountedPrice ?? price)
                                        .toStringAsFixed(0),
                                    style: context.typography.display.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: context.colors.accent,
                                      fontSize: 26.sp,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    context.l10n.egp_text,
                                    style:
                                        context.typography.titleMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.colors.accent,
                                    ),
                                  ),
                                  if (discountedPrice != null) ...[
                                    SizedBox(width: 10.w),
                                    Text(
                                      '${price.toStringAsFixed(0)} ${context.l10n.egp_text}',
                                      style: context.typography.body.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            context.colors.textMuted,
                                        color: context.colors.textMuted,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Savings pill (right side)
                        if (savedAmount > 0) ...[
                          SizedBox(width: 10.w),
                          _SavingsPill(amount: savedAmount),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// ── Savings Pill ─────────────────────────────────────────────────────────────

class _SavingsPill extends StatelessWidget {
  const _SavingsPill({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: context.colors.success.withValues(alpha: 0.1),
          borderRadius: context.radius.smBorder,
          border: Border.all(
            color: context.colors.success.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.trending_down_rounded,
              size: 14.r,
              color: context.colors.success,
            ),
            SizedBox(height: 2.h),
            Text(
              'وفرت',
              style: context.typography.caption.copyWith(
                color: context.colors.success,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${amount.toStringAsFixed(0)} ${context.l10n.egp_text}',
              style: context.typography.caption.copyWith(
                color: context.colors.success,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
}
