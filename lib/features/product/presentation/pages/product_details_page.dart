import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/models/offer.dart' as core_offer;
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/core/widgets/favorite_button.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mousa_store/features/product/data/models/product.dart'
    as core_product;
import 'package:mousa_store/features/product/data/models/product_details_response.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_bloc.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_details_bloc.dart';
import 'package:mousa_store/features/product/presentation/bloc/review_bloc.dart';
import 'package:mousa_store/features/product/presentation/widgets/add_review_section.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_accordion.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_attribute_section.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_bottom_action_bar.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_info_section.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_reviews_section.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_share_helper.dart';

typedef ProductDetailsView = ProductDetailsPage;

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.productId, super.key});

  final int productId;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt<ProductBloc>()
          ..add(ProductFetchRequested(productId: productId)),
      ),
      BlocProvider(create: (context) => getIt<ReviewBloc>()),
    ],
    child: const _ProductDetailsContent(),
  );
}

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent();

  @override
  Widget build(BuildContext context) => InternetStateManager(
    noInternetScreen: const NoInternetScreen(),
    onRestoreInternetConnection: () {
      context.read<ProductBloc>().add(const ProductRefreshRequested());
    },
    child: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                context.l10n.product_details_text,
                style: context.typography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: CustomLoadingIndicator(color: context.colors.primary),
            ),
          );
        }

        if (state.status == ProductStatus.failure) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                context.l10n.product_details_text,
                style: context.typography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: _ErrorPlaceholder(errorMessage: state.errorMessage),
          );
        }

        if (state.status == ProductStatus.success &&
            state.product != null &&
            state.product!.data.id != 0) {
          return BlocProvider(
            key: ValueKey('product_details_${state.product!.data.id}'),
            create: (context) =>
                ProductDetailsBloc(product: state.product!.data),
            child: _ProductDetailsSuccessView(product: state.product!.data),
          );
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              context.l10n.product_details_text,
              style: context.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _ErrorPlaceholder(
            errorMessage:
                state.errorMessage ?? context.l10n.product_load_failed_text,
          ),
        );
      },
    ),
  );
}

class _ProductDetailsSuccessView extends StatefulWidget {
  const _ProductDetailsSuccessView({required this.product});

  final ProductDetail product;

  @override
  State<_ProductDetailsSuccessView> createState() =>
      _ProductDetailsSuccessViewState();
}

class _ProductDetailsSuccessViewState
    extends State<_ProductDetailsSuccessView> {
  final FocusNode _pageFocusNode =
      FocusNode(debugLabel: 'product_details_focus');

  ProductDetail get product => widget.product;

  @override
  void dispose() {
    _pageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProductBloc, ProductState>(
    listenWhen: (previous, current) =>
        previous.product?.data != current.product?.data &&
        current.product?.data != null,
    listener: (context, state) {
      if (state.product != null) {
        context.read<ProductDetailsBloc>().add(
          ProductDetailsEvent.productUpdated(state.product!.data),
        );
      }
    },
    child: Focus(
      focusNode: _pageFocusNode,
      autofocus: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            context.l10n.product_details_text,
            style: context.typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        actions: [
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, detailsState) {
              final variant = detailsState.selectedVariant;
              final price =
                  double.tryParse(variant?.price ?? product.displayPrice) ?? 0;
              final activeOffer = variant?.offers?.firstOrNull;
              double? discountedPrice;
              if (activeOffer?.disscountPrice != null &&
                  activeOffer!.disscountPrice > 0) {
                discountedPrice =
                    price - (price * activeOffer.disscountPrice / 100);
              }

              return Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: context.colors.textPrimary,
                    ),
                    onPressed: () {
                      unawaited(
                        ProductShareHelper.shareProduct(
                          context,
                          product: product,
                          selectedVariant: variant,
                          discountedPrice: discountedPrice,
                          displayPrice: variant?.price ?? product.displayPrice,
                          discountPercentage:
                              activeOffer?.disscountPrice.toInt(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 12.w),
                    child: FavoriteButton(
                      productId: product.id,
                      size: 24.w,
                      product: core_product.Product(
                        id: product.id,
                        name: product.name,
                        desc: product.desc,
                        price: variant?.price ?? product.displayPrice,
                        imagePath: variant?.imagePath ?? product.displayImage,
                        imagesPath: product.imagesPath,
                        offers: (variant?.offers ?? [])
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: const _ProductDetailsScrollBody(),
      bottomNavigationBar: const _ProductBottomActionWrapper(),
    ),
  ),
);
}

class _ProductDetailsScrollBody extends StatelessWidget {
  const _ProductDetailsScrollBody();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, detailsState) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductInfoSection(
                    product: detailsState.product,
                    selectedVariant: detailsState.selectedVariant,
                  ),
                  _ProductDescriptionSection(product: detailsState.product),
                  const _ProductAttributesSection(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProductReviewsHeader(product: detailsState.product),
                      _ProductReviewsSection(product: detailsState.product),
                    ],
                  ),
                  _AddReviewWrapper(productId: detailsState.product.id),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      );
}

class _AddReviewWrapper extends StatelessWidget {
  const _AddReviewWrapper({required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) => BlocListener<ReviewBloc, ReviewState>(
    listener: (context, state) {
      if (state.status == ReviewStatus.success) {
        CustomSnackBar.show(context, context.l10n.review_added_text);
        context.read<ProductBloc>().add(
          const ProductRefreshRequested(showLoading: false),
        );
      } else if (state.status == ReviewStatus.failure) {
        CustomSnackBar.show(context, context.l10n.error_occurred_text);
      }
    },
    child: AddReviewSection(productId: productId),
  );
}

class _ProductBottomActionWrapper extends StatelessWidget {
  const _ProductBottomActionWrapper();

  @override
  Widget build(BuildContext context) => BlocListener<CartBloc, CartState>(
    bloc: getIt<CartBloc>(),
    listener: _handleCartState,
    child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, detailsState) => ProductBottomActionBar(
        product: detailsState.product,
        selectedVariant: detailsState.selectedVariant,
        selectedQuantity: detailsState.selectedQuantity,
        onQuantityChanged: (qty) => context
            .read<ProductDetailsBloc>()
            .add(ProductDetailsEvent.quantityChanged(qty)),
      ),
    ),
  );

  void _handleCartState(BuildContext context, CartState cartState) {
    if (cartState.actionStatus == RequestStatus.success) {
      final message = switch (cartState.successType) {
        CartSuccessType.added ||
        CartSuccessType.updated => context.l10n.product_added_to_cart_text,
        CartSuccessType.removed => context.l10n.product_removed_from_cart_text,
        null => '',
      };
      if (message.isNotEmpty) {
        CustomSnackBar.show(context, message);
      }
    } else if (cartState.actionStatus == RequestStatus.failure) {
      CustomSnackBar.show(
        context,
        cartState.errorMessage ?? context.l10n.error_occurred_text,
      );
    }
  }
}

class _ProductDescriptionSection extends StatelessWidget {
  const _ProductDescriptionSection({required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    if (product.desc.isEmpty) {
      return const SizedBox.shrink();
    }

    return ProductAccordion(
      title: context.l10n.product_description_text,
      icon: Icons.description_outlined,
      child: Text(
        product.desc,
        style: context.typography.body.copyWith(
          color: context.colors.textSecondary,
          height: 1.6,
        ),
      ),
    );
  }
}

class _ProductAttributesSection extends StatelessWidget {
  const _ProductAttributesSection();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, detailsState) {
          final product = detailsState.product;
          if (product.properties?.values.isEmpty ?? true) {
            return const SizedBox.shrink();
          }

          final entries = product.properties!.values.entries.toList()
            ..sort((a, b) {
              final aKey = a.key.trim().toLowerCase();
              final bKey = b.key.trim().toLowerCase();
              final isAColor = aKey == 'color' || aKey == 'اللون';
              final isBColor = bKey == 'color' || bKey == 'اللون';

              if (isAColor && !isBColor) return -1;
              if (!isAColor && isBColor) return 1;
              return 0;
            });

          return ProductAccordion(
            title: context.l10n.product_properties_text,
            icon: Icons.tune_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entries.map((entry) {
                final attributeKey = entry.key;
                final values = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Text(
                        attributeKey,
                        style: context.typography.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ProductAttributeSection(
                      values: values,
                      availableValues: detailsState.getAvailableValues(
                        attributeKey,
                      ),
                      selectedValue:
                          detailsState.selectedAttributes[attributeKey],
                      onValueSelected: (value) =>
                          context.read<ProductDetailsBloc>().add(
                            ProductDetailsEvent.attributeChanged(
                              key: attributeKey,
                              value: value,
                            ),
                          ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                );
              }).toList(),
            ),
          );
        },
      );
}

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder({required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 80.w, color: context.colors.error),
        SizedBox(height: 16.h),
        Text(context.l10n.error_occurred_text, style: context.typography.h2),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            errorMessage ?? context.l10n.product_load_failed_text,
            style: context.typography.body,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24.h),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          label: Text(context.l10n.back_text),
        ),
      ],
    ),
  );
}

class _ProductReviewsHeader extends StatelessWidget {
  const _ProductReviewsHeader({required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    if (product.reviews == null || product.reviews!.isEmpty) {
      return const SizedBox.shrink();
    }

    final reviewsTitle = context.l10n.product_reviews_text;
    final viewAllText = context.l10n.view_all_text;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.star_outline_rounded,
                size: 20.r,
                color: context.colors.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                reviewsTitle,
                style: context.typography.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              Focus.maybeOf(context)?.requestFocus();
              FocusManager.instance.primaryFocus?.unfocus();
              await showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: context.colors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                builder: (context) => AllReviewsSheet(product: product),
              );
              if (context.mounted) {
                Focus.maybeOf(context)?.requestFocus();
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: Text(
              viewAllText,
              style: context.typography.body.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductReviewsSection extends StatelessWidget {
  const _ProductReviewsSection({required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    if (product.reviews == null || product.reviews!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ProductReviewsSection(product: product),
    );
  }
}
