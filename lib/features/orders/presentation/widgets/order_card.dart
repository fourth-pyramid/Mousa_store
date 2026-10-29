import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.type,
    required this.orderNumber,
    required this.orderDate,
    required this.deliveredText,
    required this.deliveredColor,
    this.onTap,
    super.key,
  });

  final String orderNumber;
  final String orderDate;
  final String type;
  final String deliveredText;
  final Color deliveredColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    color: context.colors.surface,
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
    child: InkWell(
      borderRadius: context.radius.mdBorder,
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                end: 10,
                top: 37,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderNumber,
                    style: context.typography.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(orderDate, style: context.typography.body),
                  const SizedBox(height: 8),
                  Text(type, style: context.typography.body),
                ],
              ),
            ),

            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: deliveredColor,
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(12),
                    topEnd: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    deliveredText,
                    style: context.typography.caption.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
