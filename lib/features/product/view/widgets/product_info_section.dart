import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/models/offer.dart' as core_offer;
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_badge.dart';
import 'package:mousa_store/core/widgets/favorite_button.dart';
import 'package:mousa_store/features/product/model/product.dart'
    as core_product;
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/view/widgets/product_image_carousel.dart';
import 'package:mousa_store/features/product/view/widgets/product_share_helper.dart';

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
    if (activeOffer?.disscountPrice != null) {
      final discountPercentage = activeOffer!.disscountPrice;
      discountedPrice = price - (price * discountPercentage / 100);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ActionsRow(
          product: product,
          selectedVariant: selectedVariant,
          displayPrice: displayPrice,
          discountedPrice: discountedPrice,
          activeOffer: activeOffer,
        ),

        ProductImageCarousel(images: images),

        _BrandAndRatingRow(product: product),

        _NameAndPriceRow(
          product: product,
          price: price,
          discountedPrice: discountedPrice,
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

class _BrandAndRatingRow extends StatelessWidget {
  const _BrandAndRatingRow({required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '${context.l10n.brand_text} :',
              style: context.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              product.brand?.name ?? '',
              style: context.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({
    required this.product,
    required this.selectedVariant,
    required this.displayPrice,
    required this.discountedPrice,
    required this.activeOffer,
  });

  final ProductDetail product;
  final ProductVariant? selectedVariant;
  final String displayPrice;
  final double? discountedPrice;
  final ProductOffer? activeOffer;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(
      children: [
        if (discountedPrice != null)
          AppBadge(
            label: '-${activeOffer!.disscountPrice.toInt()}%',
            variant: AppBadgeVariant.accent,
          ),
        const Spacer(),
        CircleAvatar(
          backgroundColor: context.colors.surface,
          child: IconButton(
            icon: Icon(Icons.share, color: context.colors.primary),
            onPressed: () {
              unawaited(
                ProductShareHelper.shareProduct(
                  context,
                  product: product,
                  selectedVariant: selectedVariant,
                  discountedPrice: discountedPrice,
                  displayPrice: displayPrice,
                  discountPercentage: activeOffer?.disscountPrice.toInt(),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 8.w),
        FavoriteButton(
          productId: product.id,
          size: 28.w,
          product: core_product.Product(
            id: product.id,
            name: product.name,
            desc: product.desc,
            price: displayPrice,
            imagePath: selectedVariant?.imagePath ?? product.displayImage,
            imagesPath: product.imagesPath,
            offers: (selectedVariant?.offers ?? [])
                .map(
                  (o) => core_offer.Offer(
                    id: o.id,
                    start: o.start,
                    end: o.end,
                    productId: o.productId ?? 0,
                    createdAt: o.createdAt,
                    updatedAt: o.updatedAt,
                    discountPrice: o.disscountPrice,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

class _NameAndPriceRow extends StatelessWidget {
  const _NameAndPriceRow({
    required this.product,
    required this.price,
    required this.discountedPrice,
  });

  final ProductDetail product;
  final double price;
  final double? discountedPrice;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name,
            style: context.typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (discountedPrice != null) ...[
              Text(
                '${discountedPrice!.toStringAsFixed(0)} ${context.l10n.egp_text}',
                style: context.typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
              Text(
                '${price.toStringAsFixed(0)} ${context.l10n.egp_text}',
                style: context.typography.bodySmall.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: context.colors.textSecondary,
                ),
              ),
            ] else ...[
              Text(
                '${price.toStringAsFixed(0)} ${context.l10n.egp_text}',
                style: context.typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}
