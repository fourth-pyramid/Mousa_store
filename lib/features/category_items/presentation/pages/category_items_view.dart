import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/auto_refresh_on_reconnect.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_bloc.dart';
import 'package:mousa_store/features/category_items/presentation/widgets/category_items_empty_state.dart';
import 'package:mousa_store/features/category_items/presentation/widgets/category_items_grid.dart';
import 'package:mousa_store/features/category_items/presentation/widgets/search_and_filters.dart';

class CategoryItemsView extends StatefulWidget {
  const CategoryItemsView({
    required this.fetchType,
    this.categoryName,
    this.categoryId,
    this.brandName,
    this.brandId,
    super.key,
  });

  final ItemFetchType fetchType;
  final String? categoryName;
  final int? categoryId;
  final String? brandName;
  final int? brandId;

  @override
  State<CategoryItemsView> createState() => _CategoryItemsViewState();
}

class _CategoryItemsViewState extends State<CategoryItemsView>
    with AutoRefreshOnReconnect<CategoryItemsView> {
  @override
  void onReconnect() {
    if (mounted) {
      context.read<CategoryItemsBloc>().add(
        CategoryItemsFetchRequested(
          fetchType: widget.fetchType,
          categoryId: widget.categoryId,
          brandId: widget.brandId,
        ),
      );
    }
  }

  late final ScrollController _scrollController;
  final _showBackToTopButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _showBackToTopButton.dispose();
    super.dispose();
  }

  void _onScroll() {
    _showBackToTopButton.value = _scrollController.offset > 500;
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (widget.fetchType) {
      case ItemFetchType.category:
        title = widget.categoryName ?? context.l10n.products_plural_text;
        break;
      case ItemFetchType.brand:
        title = widget.brandName ?? context.l10n.all_brands_text;
        break;
      case ItemFetchType.recently:
        title = context.l10n.recently_arrived_text;
        break;
      case ItemFetchType.offers:
        title = context.l10n.offers_discount_text;
        break;
    }

    return BlocProvider(
      create: (context) =>
          getIt<CategoryItemsBloc>(
            param1: widget.fetchType,
            param2: widget.fetchType == ItemFetchType.brand
                ? widget.brandId
                : widget.categoryId,
          )..add(
            CategoryItemsFetchRequested(
              fetchType: widget.fetchType,
              categoryId: widget.categoryId,
              brandId: widget.brandId,
            ),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title.toUpperCase()),
          backgroundColor: context.colors.background,
        ),
        body: BlocBuilder<CategoryItemsBloc, CategoryItemsState>(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.products != current.products ||
              previous.errorMessage != current.errorMessage ||
              previous.hasReachedMax != current.hasReachedMax,
          builder: (context, state) => RefreshIndicator(
            color: context.colors.primary,
            onRefresh: () async {
              context.read<CategoryItemsBloc>().add(
                CategoryItemsFetchRequested(
                  fetchType: widget.fetchType,
                  categoryId: widget.categoryId,
                  brandId: widget.brandId,
                ),
              );
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(child: SearchAndFilters()),
                CategoryItemsGrid(
                  state: state,
                  theme: Theme.of(context),
                  scrollController: _scrollController,
                  emptyWidget: const CategoryItemsEmptyState(),
                ),
                if (state.status == CategoryItemsStatus.success &&
                    !state.hasReachedMax)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomLoadingIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: _showBackToTopButton,
          builder: (context, visible, child) => visible
              ? FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    unawaited(
                      _scrollController.animateTo(
                        0,
                        duration: context.durations.pageTransition,
                        curve: Curves.easeInOut,
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_upward, size: 18),
                )
              : const SizedBox.shrink(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}
