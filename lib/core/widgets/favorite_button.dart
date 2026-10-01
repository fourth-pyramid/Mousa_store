import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/show_login_dialog.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    required this.productId,
    required this.product,
    this.size,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    super.key,
  });

  final int productId;
  final Product product;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<bool> _isFavoriteNotifier;
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isFavoriteNotifier = ValueNotifier<bool>(
      getIt<FavoriteBloc>().isFavorite(widget.productId),
    );
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 55,
      ),
    ]).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    _isFavoriteNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<FavoriteBloc, FavoriteState>(
        bloc: getIt<FavoriteBloc>(),
        listener: (context, state) {
          final isFav = state.isFavorite(widget.productId);
          if (_isFavoriteNotifier.value != isFav) {
            _isFavoriteNotifier.value = isFav;
          }
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: _isFavoriteNotifier,
          builder: (context, isFavorite, child) {
            final heartColor = isFavorite
                ? (widget.activeColor ?? AppColorTokens.accent)
                : (widget.inactiveColor ?? const Color(0xFF374151));

            final buttonSize = widget.size ?? 32.r;
            final iconSize = (buttonSize * 0.54).clamp(14.0, 22.0);

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (getIt<AuthService>().isLoggedIn) {
                  _isFavoriteNotifier.value = !isFavorite;
                  unawaited(_animController.forward(from: 0.0));
                  getIt<FavoriteBloc>().add(
                    FavoriteToggled(
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
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, animChild) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: animChild,
                ),
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ??
                        Colors.white.withValues(alpha: 0.94),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.06),
                      width: 0.8.r,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: iconSize,
                    color: heartColor,
                  ),
                ),
              ),
            );
          },
        ),
      );
}
