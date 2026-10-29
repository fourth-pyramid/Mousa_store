import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/core/widgets/app_skeleton.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_state.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

class HomeAllProductsSection extends StatelessWidget {
  const HomeAllProductsSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
    buildWhen: (previous, current) =>
        previous.allProductsStatus != current.allProductsStatus ||
        previous.allProductsPaginationStatus !=
            current.allProductsPaginationStatus ||
        previous.allProducts != current.allProducts ||
        previous.hasReachedMax != current.hasReachedMax,
    builder: (context, state) => SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              AppSectionHeader(title: context.l10n.all_products_text),
              const SizedBox(height: 12),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: AppSliverGrid<Product>(
            items: state.allProducts,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            isLoading: state.allProductsStatus == RequestStatus.loading,
            isError: state.allProductsStatus == RequestStatus.failure,
            errorMessage: state.errorMessage,
            itemBuilder: (context, product, index) =>
                ProductGridCard(product: product),
            loadingBuilder: (context, index) => const AppSkeletonCard(),
          ),
        ),
        if (state.allProductsPaginationStatus == RequestStatus.loading &&
            !state.hasReachedMax)
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CustomLoadingIndicator(),
              ),
            ),
          ),
      ],
    ),
  );
}
