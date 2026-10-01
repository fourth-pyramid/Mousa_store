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
    margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
    child: InkWell(
      borderRadius: context.radius.mdBorder,
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 10.w,
                top: 37.h,
                bottom: 16.h,
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
                  SizedBox(height: 8.h),
                  Text(orderDate, style: context.typography.body),
                  SizedBox(height: 8.h),
                  Text(type, style: context.typography.body),
                ],
              ),
            ),

            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: deliveredColor,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(12.r),
                    topEnd: Radius.circular(12.r),
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
