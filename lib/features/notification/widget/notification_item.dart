import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/features/cart/models/cart_response.dart';
import 'package:mousa_store/features/cart/repositories/cart_repo.dart';
import 'package:mousa_store/features/favorites/repositories/favorite_repo.dart';
import 'package:mousa_store/features/notification/model/notification_model.dart';
import 'package:mousa_store/features/notification/view_model/notification_cubit.dart';
import 'package:mousa_store/features/orders/view/widgets/order_details_view.dart';
import 'package:mousa_store/features/product/view/product_details_view.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({required this.notification, super.key});

  final NotificationModel notification;

  String _formatDateTime(BuildContext context) =>
      DateFormat('dd/MM/yyyy hh:mm a').format(notification.time);

  Future<void> _handleNotificationTap(BuildContext context) async {
    final cubit = context.read<NotificationCubit>();
    if (!notification.isRead && !cubit.isNotificationRead(notification.id)) {
      cubit.markAsReadLocally(notification.id);
    }

    if (notification.data != null) {
      final productIdRaw = notification.data!['product_id'];
      final orderIdRaw = notification.data!['order_id'];

      final productId = productIdRaw is int
          ? productIdRaw
          : (productIdRaw is String ? int.tryParse(productIdRaw) : null);

      final orderId = orderIdRaw is int
          ? orderIdRaw
          : (orderIdRaw is String ? int.tryParse(orderIdRaw) : null);

      if (productId != null && _shouldNavigateToProduct(notification.type)) {
        try {
          final results = await Future.wait([
            getIt<CartRepo>().getCart(),
            getIt<FavoriteRepo>().getFavorites(),
          ]);

          final cartResponse = results[0];
          final favoritesResponse = results[1] as Map<String, dynamic>?;

          var isInCart = false;
          if (cartResponse != null && cartResponse is CartResponse) {
            final cart = cartResponse.cart;
            if (cart != null) {
              isInCart = cart.items.any((item) => item.productId == productId);
            }
          }

          var isInFavorites = false;
          if (favoritesResponse != null &&
              (favoritesResponse['data'] as Map<String, dynamic>?) != null &&
              ((favoritesResponse['data'] as Map<String, dynamic>)['data']
                      as List?) !=
                  null) {
            final data =
                (favoritesResponse['data'] as Map<String, dynamic>)['data']
                    as List;
            for (final e in data) {
              final item = e as Map<String, dynamic>;
              final id = item['id'] is int
                  ? item['id']
                  : (item['id'] is String ? int.tryParse(item['id'] as String) : null);
              if (id == productId) {
                isInFavorites = true;
                break;
              }
            }
          }

          if ((notification.type == NotificationType.cartOffer ||
                  notification.type == NotificationType.lowStock) &&
              !isInCart) {
            if (context.mounted) {
              _showErrorMessage(
                context,
                customMessage: context.l10n.item_not_in_cart,
              );
            }
            return;
          }

          if ((notification.type == NotificationType.favoriteOffer ||
                  notification.type == NotificationType.lowStockFavorite) &&
              !isInFavorites) {
            if (context.mounted) {
              _showErrorMessage(
                context,
                customMessage: context.l10n.item_not_in_favorites,
              );
            }
            return;
          }

          if (notification.type == NotificationType.limitedStock &&
              !isInCart &&
              !isInFavorites) {
            if (context.mounted) {
              _showErrorMessage(
                context,
                customMessage: context.l10n.item_not_in_cart_or_favorites,
              );
            }
            return;
          }
        } on Exception {
          if (context.mounted) _showErrorMessage(context);
          return;
        }
      }

      if (!context.mounted) return;

      if (productId != null && _shouldNavigateToProduct(notification.type)) {
        unawaited(Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ProductDetailsView(productId: productId),
          ),
        ));
      }
      else if (orderId != null &&
          notification.type == NotificationType.orderStatus) {
        unawaited(Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => OrderDetailsView(orderId: orderId),
          ),
        ));
      }
      else {
        _showErrorMessage(context);
      }
    } else {
      _showErrorMessage(context);
    }
  }

  void _showErrorMessage(BuildContext context, {String? customMessage}) {
    final message =
        customMessage ??
        (notification.type == NotificationType.favoriteOffer ||
                notification.type == NotificationType.cartOffer
            ? context.l10n.offer_no_longer_available
            : notification.type == NotificationType.orderStatus
            ? context.l10n.cannot_display_order_details
            : context.l10n.content_not_available);

    CustomSnackBar.show(context, message);
  }

  bool _shouldNavigateToProduct(NotificationType type) =>
      type == NotificationType.favoriteOffer ||
      type == NotificationType.cartOffer ||
      type == NotificationType.lowStock ||
      type == NotificationType.lowStockFavorite ||
      type == NotificationType.limitedStock ||
      type == NotificationType.specialOffer;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    final isUnread =
        !notification.isRead && !cubit.isNotificationRead(notification.id);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Material(
        color: isUnread
            ? context.colors.primary.withAlpha((0.15 * 255).toInt())
            : context.colors.transparent,
        borderRadius: context.radius.mdBorder,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _handleNotificationTap(context),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(context),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: context.typography.body.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        notification.subtitle,
                        style: context.typography.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _formatDateTime(context),
                        style: context.typography.caption.copyWith(
                          color: context.colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    switch (notification.type) {
      case NotificationType.orderConfirmed:
      case NotificationType.orderShipped:
      case NotificationType.paymentSuccess:
      case NotificationType.orderStatus:
        final isCancelled =
            notification.subtitle.contains('إلغاء') ||
            notification.title.contains('إلغاء') ||
            (notification.data != null &&
                notification.data!['status'] == 'cancelled');
        if (isCancelled) {
          return _iconContainer(
            context,
            icon: Icons.cancel_outlined,
            backgroundColor: const Color(0xFFFFEBEE),
            iconColor: context.colors.error,
          );
        }
        return _iconContainer(
          context,
          icon: Icons.local_shipping_outlined,
          backgroundColor: const Color(0xFFE3F2FD),
          iconColor: context.colors.info,
        );
      case NotificationType.specialOffer:
      case NotificationType.cartOffer:
      case NotificationType.favoriteOffer:
        return _iconContainer(
          context,
          icon: Icons.local_offer_outlined,
          backgroundColor: const Color(0xFFFFECB3),
          iconColor: context.colors.pending,
        );
      case NotificationType.reward:
        return _iconContainer(
          context,
          icon: Icons.card_giftcard,
          backgroundColor: const Color(0xFFFFE0B2),
          iconColor: context.colors.pending,
        );
      case NotificationType.limitedStock:
      case NotificationType.lowStock:
      case NotificationType.lowStockFavorite:
        return _iconContainer(
          context,
          icon: Icons.warning_amber_rounded,
          backgroundColor: const Color(0xFFFFF3E0),
          iconColor: context.colors.warning,
        );
      case NotificationType.broadcast:
        return _iconContainer(
          context,
          icon: Icons.campaign_outlined,
          backgroundColor: const Color(0xFFF3E5F5),
          iconColor: context.colors.primary,
        );
    }
  }

  Widget _iconContainer(
    BuildContext context, {
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) => Container(
    width: 48.w,
    height: 48.w,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: context.radius.smBorder,
    ),
    child: Icon(icon, color: iconColor, size: 24.w),
  );
}
