import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/product_grid_card.dart';
import 'package:mousa_store/features/auth/auth_view.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

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
        child: InternetStateManager(
          onRestoreInternetConnection: () {
            if (CacheHelper.getToken() != null) {
              unawaited(getIt<FavoriteCubit>().getFavorites());
            }
          },
          child: BlocProvider.value(
            value: getIt<FavoriteCubit>(),
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final products = switch (state) {
                  FavoriteLoaded(:final favoriteProducts) ||
                  FavoriteSuccess(:final favoriteProducts) => favoriteProducts,
                  _ => const <Product>[],
                };

                final isLoading = state is FavoriteLoading;
                final isError = state is FavoriteError;
                final errorMessage = switch (state) {
                  FavoriteError(:final message) => message,
                  _ => null,
                };

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
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 12.h,
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
                    SliverToBoxAdapter(child: SizedBox(height: 100.h)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
