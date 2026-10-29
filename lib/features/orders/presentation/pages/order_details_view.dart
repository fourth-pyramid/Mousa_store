import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_bloc.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_state.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({required this.orderId, super.key});

  final int orderId;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  late final OrderDetailsBloc _bloc;
  StreamSubscription<void>? _networkRestoreSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<OrderDetailsBloc>();
    unawaited(_bloc.getOrderDetails(widget.orderId));
    _networkRestoreSubscription = getIt<InternetConnectionService>()
        .connectivityRestoredStream
        .listen((_) {
          if (mounted) {
            unawaited(_bloc.getOrderDetails(widget.orderId));
          }
        });
  }

  @override
  void dispose() {
    unawaited(_networkRestoreSubscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _bloc,
    child: Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.order_details_text),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
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

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 10,
                  bottom: 25,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppImage(
                                  image: product.image,
                                  width: 80,
                                  height: 100,
                                  borderRadius: context.radius.smBorder,
                                ),
                                const SizedBox(width: 12),
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
                                      const SizedBox(height: 4),
                                      Text(
                                        '${context.l10n.order_number_text}: ${order.orderNumber}',
                                        style: context.typography.bodySmall
                                            .copyWith(
                                              color:
                                                  context.colors.textSecondary,
                                            ),
                                      ),
                                      Text(
                                        '${context.l10n.order_date_text}: ${DateFormat('yyyy-MM-dd').format(order.createdAt)}',
                                        style: context.typography.bodySmall
                                            .copyWith(
                                              color:
                                                  context.colors.textSecondary,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      if (product.attributes != null &&
                                          product.attributes!.isNotEmpty)
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 4,
                                          children: product.attributes!.entries
                                              .map(
                                                (entry) => Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: context
                                                        .colors
                                                        .primary
                                                        .withAlpha(
                                                          (0.1 * 255).toInt(),
                                                        ),
                                                    borderRadius:
                                                        context.radius.xsBorder,
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
                                        const SizedBox(height: 8),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8.0,
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
                          const SizedBox(height: 8),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.price_summary_text,
                            style: context.typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
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
    padding: const EdgeInsets.only(bottom: 8),
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
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
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
    padding: const EdgeInsets.only(bottom: 8),
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
