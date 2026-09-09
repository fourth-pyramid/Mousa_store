import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/features/cart/models/cart_response.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/cart/views/widgets/cart_item.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({required this.items, super.key});
  final List<CartItem> items;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    separatorBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Divider(height: 1, thickness: 1, color: context.colors.divider),
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Dismissible(
        key: Key(item.id.toString()),
        direction: DismissDirection.endToStart,
        background: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
          child: Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: EdgeInsetsDirectional.only(end: 15.w),
            decoration: BoxDecoration(
              color: context.colors.error,
              borderRadius: context.radius.mdBorder,
            ),
            child: Icon(
              Icons.delete,
              color: context.colors.onError,
              size: 32.w,
            ),
          ),
        ),
        confirmDismiss: (direction) async =>
            await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(context.l10n.delete_confirmation_title),
                content: Text(
                  '${context.l10n.delete_confirmation_message_text} (${item.name}) ${context.l10n.from_cart_text}؟',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(context.l10n.close_text),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: TextButton.styleFrom(
                      foregroundColor: context.colors.error,
                    ),
                    child: Text(context.l10n.delete_text),
                  ),
                ],
              ),
            ) ??
            false,

        onDismissed: (direction) {
          unawaited(context.read<CartCubit>().removeItem(cartItemId: item.id));
          CustomSnackBar.show(
            context,
            '${context.l10n.removed_text} ${item.name} ${context.l10n.from_cart_text}',
          );
        },
        child: CartItemWidget(
          name: item.name,
          specs: item.desc,
          image: item.imagePath,
          price: double.tryParse(item.price) ?? 0.0,
          quantity: item.quantity,
          cartItemId: item.id,
          minQuantity: item.minQuantity ?? 1,
          stock: item.stock ?? 999999,
          offers: item.offers,
          attributes: item.itemAttributes,
        ),
      );
    },
  );
}
