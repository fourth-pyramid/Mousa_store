import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/show_login_dialog.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';
import 'package:mousa_store/features/product/model/product.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    required this.productId,
    required this.product,
    this.size,
    this.activeColor,
    this.inactiveColor,
    super.key,
  });

  final int productId;
  final Product product;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late final ValueNotifier<bool> _isFavoriteNotifier;

  @override
  void initState() {
    super.initState();
    _isFavoriteNotifier = ValueNotifier<bool>(
      getIt<FavoriteCubit>().isFavorite(widget.productId),
    );
  }

  @override
  void dispose() {
    _isFavoriteNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<FavoriteCubit, FavoriteState>(
        bloc: getIt<FavoriteCubit>(),
        listener: (context, state) {
          if (state is FavoriteLoaded || state is FavoriteSuccess) {
            final isFav = getIt<FavoriteCubit>().isFavorite(widget.productId);
            if (_isFavoriteNotifier.value != isFav) {
              _isFavoriteNotifier.value = isFav;
            }
          }
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: _isFavoriteNotifier,
          builder: (context, isFavorite, child) {
            final heartColor = isFavorite
                ? (widget.activeColor ?? context.colors.accent)
                : (widget.inactiveColor ?? context.colors.textSecondary);

            return GestureDetector(
              onTap: () {
                if (getIt<AuthService>().isLoggedIn) {
                  _isFavoriteNotifier.value = !isFavorite;
                  unawaited(
                    getIt<FavoriteCubit>().addFavorite(
                      productId: widget.productId,
                      product: widget.product,
                    ),
                  );

                  CustomSnackBar.show(
                    context,
                    _isFavoriteNotifier.value
                        ? context.l10n.product_added_to_favorites_text
                        : context.l10n.product_removed_from_favorites_text,
                  );
                } else {
                  showLoginDialog(context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colors.border),
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                  size: widget.size ?? 18.w,
                  color: heartColor,
                ),
              ),
            );
          },
        ),
      );
}
