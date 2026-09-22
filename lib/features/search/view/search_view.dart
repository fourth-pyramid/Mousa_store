import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/app_search_field.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/features/search/view_model/search_cubit.dart';
import 'package:mousa_store/features/search/view_model/search_state.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounceTimer;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      unawaited(context.read<SearchCubit>().loadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      unawaited(context.read<SearchCubit>().search(query));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      titleSpacing: 16.w,
      title: AppSearchField(
        controller: _searchController,
        autofocus: true,
        onChanged: _onSearchChanged,
        onClear: () => context.read<SearchCubit>().clearSearch(),
        hint: context.l10n.search_text(context.l10n.app_name),
      ),
    ),
    body: SafeArea(
      child: InternetStateManager(
        onRestoreInternetConnection: () {
          if (_searchController.text.isNotEmpty) {
            unawaited(
              context.read<SearchCubit>().search(_searchController.text),
            );
          }
        },
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
            if (searchState.status == SearchStatus.loading) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (searchState.status == SearchStatus.success) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 12.h,
                    ),
                    sliver: AppSliverGrid<Product>(
                      items: searchState.products,
                      isLoading: false,
                      itemBuilder: (context, product, index) =>
                          ProductGridCard(product: product),
                    ),
                  ),
                  if (searchState.isLoadingMore)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const CustomLoadingIndicator(),
                      ),
                    ),
                ],
              );
            }

            if (searchState.status == SearchStatus.empty) {
              return AppEmptyState(
                title: context.l10n.no_results_found_text,
                description: context.l10n.try_searching_different_keywords_text,
                icon: Icons.search_off_rounded,
              );
            }

            if (searchState.status == SearchStatus.failure) {
              return Center(
                child: Text(
                  searchState.errorMessage ?? context.l10n.search_failed_text,
                  style: context.typography.bodySmall.copyWith(
                    color: context.colors.error,
                  ),
                ),
              );
            }

            return AppEmptyState(
              title: context.l10n.search_products_title_text,
              description: context.l10n.search_products_desc_text,
              icon: Icons.search_rounded,
            );
          },
        ),
      ),
    ),
  );
}
