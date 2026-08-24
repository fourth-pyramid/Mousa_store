import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      height: 145.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.order_value_text,
                style: context.typography.titleMedium,
              ),
              const SizedBox(width: 6),
              Text(
                '${totalPrice.toStringAsFixed(2)}${context.l10n.currency_text} ',
                style: context.typography.titleMedium,
              ),
              const Spacer(),
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
    );
  }
}
