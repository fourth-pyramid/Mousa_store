import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/widgets/app_skeleton.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_product_mapper.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_bloc.dart';

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
    if (widget.scrollController == null)
      _internalScrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant CategoryItemsGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController == widget.scrollController) return;
    (oldWidget.scrollController ?? _internalScrollController)?.removeListener(
      _onScroll,
    );
    if (widget.scrollController == null)
      _internalScrollController ??= ScrollController();
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
      context.read<CategoryItemsBloc>().add(
        const CategoryItemsLoadMoreRequested(),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.position.extentAfter <= 400;
  }

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    sliver: AppSliverGrid<CategoryProduct>(
      items: widget.state.products,
      isLoading: widget.state.status == CategoryItemsStatus.loading,
      isError: widget.state.status == CategoryItemsStatus.failure,
      errorMessage: widget.state.errorMessage,
      emptyWidget: widget.emptyWidget,
      itemBuilder: (context, product, index) =>
          ProductGridCard(product: product.toProduct()),
      loadingBuilder: (context, index) => const AppSkeletonCard(),
    ),
  );
}
