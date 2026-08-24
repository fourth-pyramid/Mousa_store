import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/view/widgets/add_review_section.dart';
import 'package:mousa_store/features/product/view/widgets/product_accordion.dart';
import 'package:mousa_store/features/product/view/widgets/product_attribute_section.dart';
import 'package:mousa_store/features/product/view/widgets/product_bottom_action_bar.dart';
import 'package:mousa_store/features/product/view/widgets/product_info_section.dart';
import 'package:mousa_store/features/product/view/widgets/product_reviews_section.dart';
import 'package:mousa_store/features/product/view_model/product_cubit/product_cubit.dart';
import 'package:mousa_store/features/product/view_model/product_cubit/product_state.dart';
import 'package:mousa_store/features/product/view_model/product_details_controller.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_cubit.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_state.dart';
import 'package:mousa_store/features/search/view/widgets/search_text_field.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({required this.productId, super.key});

  final int productId;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) {
          final cubit = getIt<ProductCubit>();
          unawaited(cubit.fetchProduct(productId: productId));
          return cubit;
        },
      ),
      BlocProvider(create: (context) => getIt<ReviewCubit>()),
    ],
    child: const _ProductDetailsContent(),
  );
}

class _ProductDetailsContent extends StatefulWidget {
  const _ProductDetailsContent();

  @override
  State<_ProductDetailsContent> createState() => _ProductDetailsContentState();
}

class _ProductDetailsContentState extends State<_ProductDetailsContent> {
  final ValueNotifier<ProductDetailsController?> _controllerNotifier = ValueNotifier<ProductDetailsController?>(null);

  @override
  void dispose() {
    _controllerNotifier.value?.dispose();
    _controllerNotifier.dispose();
    super.dispose();
  }

  void _initController(ProductDetail product) {
    if (_controllerNotifier.value == null || _controllerNotifier.value!.product.id != product.id) {
      _controllerNotifier.value?.dispose();
      _controllerNotifier.value = ProductDetailsController(product);
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ProductDetailsController?>(
    valueListenable: _controllerNotifier,
    builder: (context, controller, _) => Scaffold(
      appBar: AppBar(title: const SearchTextField()),
      body: InternetStateManager(
        noInternetScreen: const NoInternetScreen(),
        onRestoreInternetConnection: () {
          context.read<ProductCubit>().refreshData();
        },
        child: BlocConsumer<ProductCubit, ProductState>(
          buildWhen: (previous, current) {
            if (previous.status != current.status) return true;
            if (previous.product == null && current.product != null) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state.status == ProductStatus.success && state.product != null) {
              if (controller == null) {
                _initController(state.product!.data);
              } else {
                controller.updateProduct(state.product!.data);
              }
            }
          },
          builder: (context, state) {
            if (state.status == ProductStatus.loading) {
              return Center(child: CustomLoadingIndicator(color: context.colors.primary));
            }

            if (state.status == ProductStatus.failure) {
              return _ErrorPlaceholder(errorMessage: state.errorMessage);
            }

            if (state.status == ProductStatus.success &&
                state.product != null &&
                state.product!.data.id != 0 &&
                controller != null) {
              return _ProductDetailsScrollBody(controller: controller);
            }

            return _ErrorPlaceholder(errorMessage: state.errorMessage ?? context.l10n.product_load_failed_text);
          },
        ),
      ),
      bottomNavigationBar: _ProductBottomActionWrapper(controller: controller),
    ),
  );
}

class _ProductDetailsScrollBody extends StatelessWidget {
  const _ProductDetailsScrollBody({required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) =>
                  ProductInfoSection(product: controller.product, selectedVariant: controller.selectedVariant),
            ),
            _ProductDescriptionSection(product: controller.product),
            _ProductAttributesSection(controller: controller),
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductReviewsHeader(product: controller.product),
                  _ProductReviewsSection(product: controller.product),
                ],
              ),
            ),
            _AddReviewWrapper(productId: controller.product.id),
          ],
        ),
      ),
    ],
  );
}

class _AddReviewWrapper extends StatelessWidget {
  const _AddReviewWrapper({required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) => BlocListener<ReviewCubit, ReviewState>(
    listener: (context, state) {
      if (state.status == ReviewStatus.success) {
        CustomSnackBar.show(context, context.l10n.add_your_review_text);
        context.read<ProductCubit>().refreshData(showLoading: false);
      } else if (state.status == ReviewStatus.failure) {
        CustomSnackBar.show(context, context.l10n.error_occurred_text);
      }
    },
    child: AddReviewSection(productId: productId),
  );
}

class _ProductBottomActionWrapper extends StatelessWidget {
  const _ProductBottomActionWrapper({this.controller});

  final ProductDetailsController? controller;

  @override
  Widget build(BuildContext context) => BlocListener<CartCubit, CartState>(
    bloc: getIt<CartCubit>(),
    listener: _handleCartState,
    child: BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.success &&
            state.product != null &&
            state.product!.data.id != 0 &&
            controller != null) {
          return ListenableBuilder(
            listenable: controller!,
            builder: (context, _) => ProductBottomActionBar(
              product: state.product!.data,
              selectedVariant: controller!.selectedVariant,
              selectedQuantity: controller!.selectedQuantity,
              onQuantityChanged: controller!.updateQuantity,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );

  void _handleCartState(BuildContext context, CartState cartState) {
    if (cartState.actionStatus == RequestStatus.success) {
      var message = '';
      switch (cartState.successType) {
        case CartSuccessType.added:
          message = context.l10n.product_added_to_cart_text;
        case CartSuccessType.removed:
          message = context.l10n.product_removed_from_cart_text;
        case CartSuccessType.updated:
          message = context.l10n.product_added_to_cart_text;
        case null:
          message = '';
      }
      if (message.isNotEmpty) {
        CustomSnackBar.show(context, message);
      }
    } else if (cartState.actionStatus == RequestStatus.failure) {
      CustomSnackBar.show(context, cartState.errorMessage ?? context.l10n.error_occurred_text);
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
      child: Text(
        product.desc,
        style: context.typography.body.copyWith(
          color: context.colors.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }
}

class _ProductAttributesSection extends StatelessWidget {
  const _ProductAttributesSection({required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    if (product.properties?.values.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return ProductAccordion(
      title: context.l10n.product_properties_text,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
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

          return Column(
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
                      _getAttributeTitle(attributeKey),
                      style: context.typography.body.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ProductAttributeSection(
                    values: values,
                    availableValues: controller.getAvailableValues(attributeKey),
                    selectedValue: controller.selectedAttributes[attributeKey],
                    onValueSelected: (value) => controller.updateAttribute(attributeKey, value),
                  ),
                  SizedBox(height: 8.h),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  String _getAttributeTitle(String key) => key;
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
          Text(reviewsTitle, style: context.typography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () {
              unawaited(
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: context.colors.background,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
                  builder: (context) => AllReviewsSheet(product: product),
                ),
              );
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
