import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/auth/presentation/pages/auth_page.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:mousa_store/features/product/data/models/product.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  StreamSubscription<void>? _networkRestoreSubscription;

  @override
  void initState() {
    super.initState();
    _networkRestoreSubscription = getIt<InternetConnectionService>()
        .connectivityRestoredStream
        .listen((_) {
          if (mounted && CacheHelper.getToken() != null) {
            getIt<FavoriteBloc>().add(const FavoritesFetchRequested());
          }
        });
  }

  @override
  void dispose() {
    unawaited(_networkRestoreSubscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final isLoggedIn = CacheHelper.getToken() != null;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localization.favorite_text.toUpperCase()),
          backgroundColor: context.colors.background,
        ),
        body: SafeArea(
          child: AppEmptyState(
            title: localization.favorite_text,
            description: localization.favorites_login_prompt_text,
            icon: Icons.favorite_border_rounded,
            actionLabel: localization.login_button,
            onActionTap: () {
              unawaited(
                navigateWithTransition<void>(context, const AuthView()),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.favorite_text.toUpperCase()),
        backgroundColor: context.colors.background,
      ),
      body: SafeArea(
        child: BlocProvider.value(
          value: getIt<FavoriteBloc>(),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              final products = state.favoriteProducts;
              final isLoading = state.status == FavoriteStatus.loading;
              final isError = state.status == FavoriteStatus.failure;
              final errorMessage = state.errorMessage;

              if (products.isEmpty && !isLoading) {
                return AppEmptyState(
                  title: localization.no_favorite_products_text,
                  description: localization.products_favorites_empty_text,
                  icon: Icons.favorite_border_rounded,
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    sliver: AppSliverGrid<Product>(
                      items: products,
                      isLoading: isLoading,
                      isError: isError,
                      errorMessage: errorMessage,
                      itemBuilder: (context, product, index) =>
                          ProductGridCard(product: product),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
