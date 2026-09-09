import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/auth/auth_view.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/cart/views/widgets/cart_information.dart';
import 'package:mousa_store/features/cart/views/widgets/cart_items_list.dart';

class ProductsCart extends StatefulWidget {
  const ProductsCart({super.key, this.gnToHome});
  final VoidCallback? gnToHome;

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  @override
  void initState() {
    super.initState();
    if (CacheHelper.getToken() != null) {
      unawaited(context.read<CartCubit>().getCart());
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
      body: InternetStateManager(
        onRestoreInternetConnection: () {
          if (CacheHelper.getToken() != null) {
            unawaited(context.read<CartCubit>().getCart());
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
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
                  child: BlocBuilder<CartCubit, CartState>(
                    buildWhen: (previous, current) {
                      final prevCart = previous.cart;
                      final currCart = current.cart;
                      if (prevCart == null || currCart == null) return true;
                      if (prevCart.items.length != currCart.items.length) {
                        return true;
                      }
                      for (var i = 0; i < prevCart.items.length; i++) {
                        if (prevCart.items[i].id != currCart.items[i].id) {
                          return true;
                        }
                      }
                      return false;
                    },
                    builder: (context, state) =>
                        CartItemsList(items: state.cart!.items),
                  ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) => CartInformation(
                    cart: state.cart!,
                    gnToHome: widget.gnToHome,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
