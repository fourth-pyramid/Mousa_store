import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/core/widgets/app_sliver_list.dart';
import 'package:mousa_store/core/widgets/favorite_button.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/views/category_items_view.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/features/product/model/product_summary.dart';

class HomeOffersSection extends StatelessWidget {
  const HomeOffersSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        previous.offersStatus != current.offersStatus ||
        previous.offerProducts != current.offerProducts,
    builder: (context, state) {
      if (state.offerProducts.isEmpty &&
          state.offersStatus != RequestStatus.loading) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          AppSectionHeader(
            title: context.l10n.offers_discount_text,
            actionLabel: context.l10n.view_all_text,
            onActionTap: () {
              unawaited(
                navigateWithTransition<void>(
                  context,
                  const CategoryItemsView(fetchType: ItemFetchType.offers),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          AppSliverList<Product>(
            products: state.offerProducts,
            isLoading: state.offersStatus == RequestStatus.loading,
            isError: state.offersStatus == RequestStatus.failure,
            errorMessage: state.errorMessage,
            extractProductSummary: _extractProductSummary,
            favoriteButtonBuilder: (product) =>
                FavoriteButton(productId: product.id, product: product),
          ),
        ],
      );
    },
  );

  ProductSummary _extractProductSummary(Product product) => ProductSummary(
    id: product.id,
    name: product.name,
    price: product.displayPrice,
    description: product.desc,
    imagePath: product.displayImage,
    offers: (product.offers ?? [])
        .map((offer) => BaseOffer(discountPrice: offer.discountPrice.toInt()))
        .toList(),
  );
}
