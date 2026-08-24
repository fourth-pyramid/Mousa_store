import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_section_header.dart';
import 'package:mousa_store/core/widgets/app_skeleton.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';
import 'package:mousa_store/features/product/model/product.dart';

class HomeAllProductsSection extends StatelessWidget {
  const HomeAllProductsSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        previous.allProductsStatus != current.allProductsStatus ||
        previous.allProductsPaginationStatus != current.allProductsPaginationStatus ||
        previous.allProducts != current.allProducts ||
        previous.hasReachedMax != current.hasReachedMax,
    builder: (context, state) => SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              AppSectionHeader(title: context.l10n.all_products_text),
              SizedBox(height: 12.h),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: AppSliverGrid<Product>(
            items: state.allProducts,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            isLoading: state.allProductsStatus == RequestStatus.loading,
            isError: state.allProductsStatus == RequestStatus.failure,
            errorMessage: state.errorMessage,
            itemBuilder: (context, product, index) => ProductGridCard(product: product),
            loadingBuilder: (context, index) => const AppSkeletonCard(),
          ),
        ),
        if (state.allProductsPaginationStatus == RequestStatus.loading && !state.hasReachedMax)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(padding: EdgeInsets.symmetric(vertical: 24.h), child: const CustomLoadingIndicator()),
            ),
          ),
      ],
    ),
  );
}
