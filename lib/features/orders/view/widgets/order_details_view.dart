import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/orders/view_model/order_details_cubit/order_details_cubit.dart';
import 'package:mousa_store/features/orders/view_model/order_details_cubit/order_details_state.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = getIt<OrderDetailsCubit>();
      unawaited(cubit.getOrderDetails(orderId));
      return cubit;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.order_details_text),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state.status == OrderDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == OrderDetailsStatus.success &&
              state.orderDetails != null) {
            final order = state.orderDetails!.order;
            final products = state.orderDetails!.product;
            final computedSubtotal = products.fold<double>(
              0.0,
              (sum, product) => sum + product.total,
            );

            return InternetStateManager(
              onRestoreInternetConnection: () =>
                  context.read<OrderDetailsCubit>().getOrderDetails(orderId),
              noInternetScreen: const NoInternetScreen(),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    top: 10.h,
                    bottom: 25.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        itemCount: products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            color: context.colors.surface,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppImage(
                                    image: product.image,
                                    width: 80.w,
                                    height: 100.h,
                                    borderRadius: context.radius.smBorder,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.productName,
                                          style: context.typography.titleMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '${context.l10n.order_number_text}: ${order.orderNumber}',
                                          style: context.typography.bodySmall
                                              .copyWith(
                                                color: context
                                                    .colors
                                                    .textSecondary,
                                              ),
                                        ),
                                        Text(
                                          '${context.l10n.order_date_text}: ${DateFormat('yyyy-MM-dd').format(order.createdAt)}',
                                          style: context.typography.bodySmall
                                              .copyWith(
                                                color: context
                                                    .colors
                                                    .textSecondary,
                                              ),
                                        ),
                                        SizedBox(height: 8.h),
                                        if (product.attributes != null &&
                                            product.attributes!.isNotEmpty)
                                          Wrap(
                                            spacing: 8.w,
                                            runSpacing: 4.h,
                                            children: product
                                                .attributes!
                                                .entries
                                                .map(
                                                  (entry) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 6.w,
                                                          vertical: 2.h,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: context
                                                          .colors
                                                          .primary
                                                          .withAlpha(
                                                            (0.1 * 255).toInt(),
                                                          ),
                                                      borderRadius: context
                                                          .radius
                                                          .xsBorder,
                                                    ),
                                                    child: Text(
                                                      '${entry.key}: ${entry.value ?? ""}',
                                                      style: context
                                                          .typography
                                                          .bodySmall
                                                          .copyWith(
                                                            color: context
                                                                .colors
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        if (product.attributes != null &&
                                            product.attributes!.isNotEmpty)
                                          SizedBox(height: 8.h),
                                        Text(
                                          '${context.l10n.quantity_text}: ${product.quantity}',
                                          style: context.typography.bodySmall,
                                        ),
                                        Text(
                                          '${context.l10n.unit_price_text}: ${product.price} ${context.l10n.currency_text}',
                                          style: context.typography.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 8.0.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.shipping_address_text,
                              style: context.typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            _OrderInfoRow(
                              label: context.l10n.recipient_name_text,
                              value: order.userName,
                            ),
                            _OrderInfoRow(
                              label: context.l10n.address_text,
                              value: order.userAddress,
                            ),
                            _OrderInfoRow(
                              label: context.l10n.phone_text,
                              value: order.userPhone.startsWith('+20')
                                  ? order.userPhone.replaceFirst('+2', '')
                                  : order.userPhone,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.price_summary_text,
                              style: context.typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _OrderPriceSection(
                              subtotal: computedSubtotal,
                              shipping: double.parse(order.shipping),
                              localizations: context.l10n,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.status == OrderDetailsStatus.failure) {
            return Center(child: Text(state.errorMessage ?? ''));
          }
          return const SizedBox.shrink();
        },
      ),
    ),
  );
}

class _OrderInfoRow extends StatelessWidget {
  const _OrderInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Row(
      children: [
        Text(
          '$label: ',
          style: context.typography.body.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        Expanded(child: Text(value, style: context.typography.body)),
      ],
    ),
  );
}

class _OrderPriceSection extends StatelessWidget {
  const _OrderPriceSection({
    required this.subtotal,
    required this.shipping,
    required this.localizations,
  });

  final double subtotal;
  final double shipping;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _OrderPriceItem(
        label: localizations.subtotal_text,
        value: subtotal,
        localizations: localizations,
      ),
      _OrderPriceItem(
        label: localizations.shipping_text,
        value: shipping,
        localizations: localizations,
      ),
      SizedBox(height: 8.h),
      const Divider(),
      SizedBox(height: 8.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localizations.total_text,
            style: context.typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
          Text(
            '${subtotal + shipping} ${localizations.currency_text}',
            style: context.typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
        ],
      ),
    ],
  );
}

class _OrderPriceItem extends StatelessWidget {
  const _OrderPriceItem({
    required this.label,
    required this.value,
    required this.localizations,
  });

  final String label;
  final double value;
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.typography.body.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        Text(
          '$value ${localizations.currency_text}',
          style: context.typography.body.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
