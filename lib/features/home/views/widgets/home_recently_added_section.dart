import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/core/widgets/app_sliver_list.dart';
import 'package:mousa_store/core/widgets/favorite_button.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/features/product/model/product_summary.dart';

class HomeRecentlyAddedSection extends StatelessWidget {
  const HomeRecentlyAddedSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        previous.recentlyStatus != current.recentlyStatus || previous.recentlyProducts != current.recentlyProducts,
    builder: (context, state) {
      if (state.recentlyProducts.isEmpty && state.recentlyStatus != RequestStatus.loading) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          AppSectionHeader(title: context.l10n.recently_arrived_text),
          SizedBox(height: 12.h),
          AppSliverList<Product>(
            products: state.recentlyProducts,
            isLoading: state.recentlyStatus == RequestStatus.loading,
            isError: state.recentlyStatus == RequestStatus.failure,
            errorMessage: state.errorMessage,
            extractProductSummary: _extractProductSummary,
            favoriteButtonBuilder: (product) => FavoriteButton(productId: product.id, product: product),
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
    offers: (product.offers ?? []).map((offer) => BaseOffer(discountPrice: offer.discountPrice.toInt())).toList(),
  );
}
