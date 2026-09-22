import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_fade_button.dart';
import 'package:mousa_store/features/cart/models/cart_response.dart';
import 'package:mousa_store/features/cart/views/widgets/cash_on_delivery.dart';

class CartInformation extends StatelessWidget {
  const CartInformation({required this.cart, super.key, this.gnToHome});
  final VoidCallback? gnToHome;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final itemCount = cart.items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    final totalPrice = cart.total;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          16.w,
          8.h,
          16.w,
          84.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          context.l10n.order_value_text,
                          style: context.typography.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${totalPrice.toStringAsFixed(2)}${context.l10n.currency_text} ',
                        style: context.typography.titleMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '($itemCount ${context.l10n.products_plural_text})',
                  style: context.typography.titleMedium,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 6.h),
              child: Text(
                context.l10n.delivery_charges_notice_text,
                style: context.typography.body,
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.only(top: 8.h),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomFadeButton(
                      text: context.l10n.continue_shopping_text,
                      onPressed: gnToHome ?? () {},
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    flex: 2,
                    child: CustomButton(
                      text: Text(context.l10n.checkout_text),
                      onPressed: () {
                        unawaited(
                          navigateWithTransition<void>(
                            context,
                            CashOnDelivery(
                              totalPrice: totalPrice.toStringAsFixed(2),
                            ),
                            type: TransitionType.fade,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
