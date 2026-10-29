import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_fade_button.dart';
import 'package:mousa_store/features/cart/data/models/cart_response.dart';
import 'package:mousa_store/features/cart/presentation/widgets/cash_on_delivery.dart';

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
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 84),
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
                      const SizedBox(width: 6),
                      Text(
                        '${totalPrice.toStringAsFixed(2)}${context.l10n.currency_text} ',
                        style: context.typography.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '($itemCount ${context.l10n.products_plural_text})',
                  style: context.typography.titleMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 6),
              child: Text(
                context.l10n.delivery_charges_notice_text,
                style: context.typography.body,
              ),
            ),

            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomFadeButton(
                      text: context.l10n.continue_shopping_text,
                      onPressed: gnToHome ?? () {},
                    ),
                  ),
                  const SizedBox(width: 6),
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
