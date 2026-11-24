import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/auto_refresh_on_reconnect.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/auth/presentation/pages/auth_page.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mousa_store/features/cart/presentation/widgets/cart_information.dart';
import 'package:mousa_store/features/cart/presentation/widgets/cart_items_list.dart';

typedef ProductsCart = CartPage;

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.gnToHome});
  final VoidCallback? gnToHome;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutoRefreshOnReconnect<CartPage> {
  @override
  void onReconnect() {
    if (CacheHelper.getToken() != null) {
      context.read<CartBloc>().add(const CartFetchRequested());
    }
  }

  @override
  void initState() {
    super.initState();
    if (CacheHelper.getToken() != null) {
      context.read<CartBloc>().add(const CartFetchRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = CacheHelper.getToken() != null;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.shopping_cart_text.toUpperCase()),
          backgroundColor: context.colors.background,
        ),
        body: SafeArea(
          child: AppEmptyState(
            title: context.l10n.shopping_cart_text,
            description: context.l10n.cart_login_prompt_text,
            icon: Icons.shopping_bag_outlined,
            actionLabel: context.l10n.login_button,
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
        title: Text(context.l10n.shopping_cart_text.toUpperCase()),
        backgroundColor: context.colors.background,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) =>
            (previous.status == RequestStatus.loading &&
                    previous.cart == null) !=
                (current.status == RequestStatus.loading &&
                    current.cart == null) ||
            (previous.cart?.items.isEmpty ?? true) !=
                (current.cart?.items.isEmpty ?? true),
        builder: (context, state) {
          if (state.status == RequestStatus.loading && state.cart == null) {
            return const Center(child: CustomLoadingIndicator());
          }

          final cart = state.cart;

          if (cart == null || cart.items.isEmpty) {
            return AppEmptyState(
              title: context.l10n.empty_cart_text,
              description: context.l10n.start_adding_products_text,
              actionLabel: context.l10n.explore_products_text,
              onActionTap: widget.gnToHome,
              icon: Icons.shopping_bag_outlined,
            );
          }

          return Column(
            children: [
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) =>
                      previous.cart?.items != current.cart?.items,
                  builder: (context, state) =>
                      CartItemsList(items: state.cart?.items ?? const []),
                ),
              ),
              BlocSelector<CartBloc, CartState, ({double total, int count})>(
                selector: (state) => (
                  total: state.cart?.total ?? 0,
                  count:
                      state.cart?.items.fold<int>(
                        0,
                        (sum, item) => sum + item.quantity,
                      ) ??
                      0,
                ),
                builder: (context, totals) => CartInformation(
                  totalPrice: totals.total,
                  itemCount: totals.count,
                  gnToHome: widget.gnToHome,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
