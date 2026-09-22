import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_list_card.dart';
import 'package:mousa_store/features/product/model/product_summary.dart';
import 'package:mousa_store/features/product/view/product_details_view.dart';
import 'package:mousa_store/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSliverList<T> extends StatelessWidget {
  const AppSliverList({
    required this.products,
    required this.isLoading,
    required this.isError,
    required this.extractProductSummary,
    this.theme,
    this.favoriteButtonBuilder,
    this.errorMessage,
    this.maxItems = 10,
    this.padding,
    super.key,
  });

  final ThemeData? theme;
  final List<T> products;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final int maxItems;
  final EdgeInsetsGeometry? padding;
  final ProductSummary Function(T) extractProductSummary;
  final Widget Function(T)? favoriteButtonBuilder;

  double _cardWidth(double maxWidth) {
    if (maxWidth >= 1200) return 200.w;
    if (maxWidth >= 800) return 180.w;
    return (maxWidth * 0.40).clamp(140.0.w, 160.0.w);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final cardWidth = _cardWidth(constraints.maxWidth);

      if (isLoading) {
        return _SliverListSkeleton(cardWidth: cardWidth);
      }

      if (isError) {
        return Center(
          child: Text(
            errorMessage ?? context.l10n.error_text,
            style: context.typography.body,
          ),
        );
      }

      if (products.isEmpty) {
        return Center(
          child: Text(
            context.l10n.no_products_found_text,
            style: context.typography.body,
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
        child: IntrinsicHeight(
          child: Row(
            children: List.generate(
              products.length > maxItems ? maxItems : products.length,
              (index) {
                final product = extractProductSummary(products[index]);

                return Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: SizedBox(
                    width: cardWidth,
                    child: _SliverProductCardItem(
                      product: product,
                      favoriteButton: favoriteButtonBuilder?.call(
                        products[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

class _SliverProductCardItem extends StatelessWidget {
  const _SliverProductCardItem({required this.product, this.favoriteButton});

  final ProductSummary product;
  final Widget? favoriteButton;

  @override
  Widget build(BuildContext context) {
    final price = double.tryParse(product.price) ?? 0;
    var finalPrice = price;
    var oldPrice = '';
    int? discount;

    if (product.offers.isNotEmpty) {
      final offer = product.offers.first;
      discount = offer.discountPrice;
      oldPrice = price.toStringAsFixed(0);
      finalPrice = price - (price * discount / 100);
    }

    return AppListCard(
      title: product.name,
      price: finalPrice.toStringAsFixed(0),
      oldPrice: oldPrice,
      description: product.description,
      image: product.imagePath,
      discount: discount,
      favoriteButton: favoriteButton,
      priceLabel: AppLocalizations.of(context)!.egp_text,
      discountLabel: AppLocalizations.of(context)!.discount_text,
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

class _SliverListSkeleton extends StatelessWidget {
  const _SliverListSkeleton({required this.cardWidth});

  final double cardWidth;

  @override
  Widget build(BuildContext context) => Skeletonizer(
    ignoreContainers: true,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsetsDirectional.only(end: 12.w),
              child: SizedBox(
                width: cardWidth,
                child: AppListCard(
                  title: 'Loading',
                  price: '99',
                  oldPrice: '129',
                  description: 'Loading description',
                  image: '',
                  discount: 20,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
