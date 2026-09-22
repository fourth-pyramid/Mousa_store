import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_grid_card.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/brands/models/brand.dart' as core_brand;
import 'package:mousa_store/features/category_items/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryItemsGrid extends StatefulWidget {
  const CategoryItemsGrid({
    required this.state,
    this.theme,
    this.scrollController,
    this.emptyWidget,
    super.key,
  });

  final ThemeData? theme;
  final ScrollController? scrollController;
  final CategoryItemsState state;
  final Widget? emptyWidget;

  @override
  State<CategoryItemsGrid> createState() => _CategoryItemsGridState();
}

class _CategoryItemsGridState extends State<CategoryItemsGrid> {
  ScrollController? _internalScrollController;
  ScrollController get _scrollController =>
      widget.scrollController ?? _internalScrollController!;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _internalScrollController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      unawaited(context.read<CategoryItemsCubit>().loadMoreItems());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 4.0.w),
    sliver: AppSliverGrid<CategoryProduct>(
      items: widget.state.products,
      isLoading: widget.state.status == CategoryItemsStatus.loading,
      isError: widget.state.status == CategoryItemsStatus.failure,
      errorMessage: widget.state.errorMessage,
      emptyWidget: widget.emptyWidget,
      itemBuilder: (context, product, index) => ProductGridCard(
        product: Product(
          id: product.id ?? 0,
          name: product.name ?? '',
          desc: product.desc ?? '',
          price: product.price ?? '0',
          imagePath: product.imagePath ?? '',
          imagesPath: product.imagesPath ?? [],
          brand: product.brand != null
              ? core_brand.Brand(
                  id: product.brand!.id ?? 0,
                  name: product.brand!.name ?? '',
                  imagePath: product.brand!.imagePath ?? '',
                )
              : null,
          offers: product.offers,
          variants: product.variants,
        ),
      ),
      loadingBuilder: (context, index) => Skeletonizer(
        child: AppGridCard(
          title: 'Loading Product Name...',
          image: '',
          price: '000',
          priceLabel: context.l10n.egp_text,
          onTap: () {},
        ),
      ),
    ),
  );
}
