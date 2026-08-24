import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';
import 'package:mousa_store/features/category_items/views/widgets/category_items_empty_state.dart';
import 'package:mousa_store/features/category_items/views/widgets/category_items_grid.dart';
import 'package:mousa_store/features/category_items/views/widgets/search_and_filters.dart';

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

class _CategoryItemsViewState extends State<CategoryItemsView> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 500 && !_showBackToTopButton) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else if (_scrollController.offset <= 500 && _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = false;
      });
    }
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
      create: (context) {
        final cubit = getIt<CategoryItemsCubit>(
          param1: widget.fetchType,
          param2: widget.fetchType == ItemFetchType.brand
              ? widget.brandId
              : widget.categoryId,
        );
        unawaited(cubit.fetchItems());
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title.toUpperCase()),
          backgroundColor: context.colors.background,
        ),
        body: BlocBuilder<CategoryItemsCubit, CategoryItemsState>(
          builder: (context, state) => InternetStateManager(
            noInternetScreen: const NoInternetScreen(),
            onRestoreInternetConnection: () {
              unawaited(context.read<CategoryItemsCubit>().fetchItems());
            },
            child: RefreshIndicator(
              color: context.colors.primary,
              onRefresh: () async {
                await context.read<CategoryItemsCubit>().fetchItems();
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
        ),
        floatingActionButton: _showBackToTopButton
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
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}
