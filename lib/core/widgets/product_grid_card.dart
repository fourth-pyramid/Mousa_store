import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_grid_card.dart';
import 'package:mousa_store/core/widgets/favorite_button.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/features/product/view/product_details_view.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final activeOffer = product.offers?.firstOrNull;
    final price = double.tryParse(product.displayPrice) ?? 0;
    double? discountedPrice;
    int? discountPercentage;

    if (activeOffer != null) {
      discountPercentage = activeOffer.discountPrice.toInt();
      discountedPrice = price - (price * discountPercentage / 100);
    }

    return AppGridCard(
      title: product.name,
      image: product.displayImage,
      price: discountedPrice != null
          ? discountedPrice.toStringAsFixed(0)
          : product.displayPrice,
      oldPrice: discountedPrice != null ? product.displayPrice : null,
      discount: discountPercentage,
      discountLabel: context.l10n.discount_text,
      priceLabel: context.l10n.egp_text,
      favoriteButton: FavoriteButton(productId: product.id, product: product),
      onTap: () {
        unawaited(
          navigateWithTransition<void>(
            context,
            ProductDetailsView(productId: product.id),
          ),
        );
      },
    );
  }
}
