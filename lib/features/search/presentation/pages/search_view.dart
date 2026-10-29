import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/app_search_field.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/product/data/models/product.dart';
import 'package:mousa_store/features/search/presentation/bloc/search_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounceTimer;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  StreamSubscription<void>? _networkRestoreSubscription;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _networkRestoreSubscription = getIt<InternetConnectionService>()
        .connectivityRestoredStream
        .listen((_) {
          if (mounted && _searchController.text.isNotEmpty) {
            context.read<SearchBloc>().add(
              SearchQueryChanged(_searchController.text),
            );
          }
        });
  }

  @override
  void dispose() {
    unawaited(_networkRestoreSubscription?.cancel());
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SearchBloc>().add(const SearchMoreRequested());
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
      context.read<SearchBloc>().add(SearchQueryChanged(query));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      titleSpacing: 16,
      title: AppSearchField(
        controller: _searchController,
        autofocus: true,
        onChanged: _onSearchChanged,
        onClear: () {
          _debounceTimer?.cancel();
          context.read<SearchBloc>().add(const SearchCleared());
        },
        hint: context.l10n.search_text(context.l10n.app_name),
      ),
    ),
    body: SafeArea(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
          if (searchState.status == SearchStatus.loading) {
            return const Center(child: CustomLoadingIndicator());
          }

          if (searchState.status == SearchStatus.success) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  sliver: AppSliverGrid<Product>(
                    items: searchState.products,
                    isLoading: false,
                    itemBuilder: (context, product, index) =>
                        ProductGridCard(product: product),
                  ),
                ),
                if (searchState.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CustomLoadingIndicator(),
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
  );
}
