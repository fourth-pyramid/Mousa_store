import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/app_search_field.dart';
import 'package:mousa_store/core/widgets/auto_refresh_on_reconnect.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_state.dart';
import 'package:mousa_store/features/orders/presentation/pages/order_details_view.dart';
import 'package:mousa_store/features/orders/presentation/widgets/order_card.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class OrderView extends StatefulWidget {
  static final _dateFormats = <String, DateFormat>{};
  static DateFormat _dateFormat(String locale) => _dateFormats.putIfAbsent(
    locale,
    () => DateFormat('yyyy-MM-dd HH:mm', locale),
  );

  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with AutoRefreshOnReconnect<OrderView> {
  @override
  void onReconnect() {
    if (mounted) {
      unawaited(_bloc.getOrders());
    }
  }

  late final OrdersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<OrdersBloc>();
    unawaited(_bloc.getOrders());
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _bloc,
    child: Scaffold(
      appBar: AppBar(title: Text(context.l10n.orders_text.toUpperCase())),
      body: RefreshIndicator(
        color: context.colors.primary,
        onRefresh: () => context.read<OrdersBloc>().getOrders(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppSearchField(
                  onChanged: (value) {
                    context.read<OrdersBloc>().updateSearchQuery(value);
                  },
                  hint: context.l10n.search_text('Orders'),
                ),
              ),
            ),
            BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state.status == OrdersStatus.loading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CustomLoadingIndicator()),
                  );
                } else if (state.status == OrdersStatus.success) {
                  if (state.orders.isEmpty) {
                    return SliverToBoxAdapter(
                      child: AppEmptyState(
                        title: context.l10n.no_orders_found_text,
                        description: 'You have no placed orders yet.',
                        icon: Icons.receipt_long_outlined,
                      ),
                    );
                  }
                  return SliverList.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final order =
                          state.orders[state.orders.length - 1 - index];
                      return OrderCard(
                        orderNumber:
                            '${context.l10n.order_number_text} : ${order.orderNumber}',
                        orderDate:
                            '${context.l10n.order_date_text} : ${OrderView._dateFormat(Localizations.localeOf(context).toString()).format(order.createdAt)}',
                        deliveredText: _getStatusText(
                          order.status,
                          context.l10n,
                        ),
                        deliveredColor: _getStatusColor(order.status, context),
                        onTap: () {
                          unawaited(
                            navigateWithTransition<void>(
                              type: TransitionType.fade,
                              context,
                              OrderDetailsView(orderId: order.id),
                            ),
                          );
                        },
                        type:
                            '${context.l10n.order_type_label_text} : ${_getOrderTypeText(order.type, context.l10n)}',
                      );
                    },
                  );
                } else if (state.status == OrdersStatus.failure) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        state.errorMessage ?? '',
                        style: context.typography.bodySmall.copyWith(
                          color: context.colors.error,
                        ),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    ),
  );

  String _getStatusText(String status, AppLocalizations localizations) {
    switch (status.toLowerCase()) {
      case 'pending':
        return localizations.pending_text;
      case 'completed':
        return localizations.delivered_text;
      case 'cancelled':
        return localizations.canceled_text;
      case 'processing':
        return localizations.shipped_text;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'pending':
        return context.colors.pending;
      case 'completed':
        return context.colors.success;
      case 'cancelled':
        return context.colors.error;
      case 'processing':
        return context.colors.info;
      default:
        return context.colors.textMuted;
    }
  }

  String _getOrderTypeText(String type, AppLocalizations localizations) {
    switch (type.toLowerCase()) {
      case 'retail':
        return localizations.retail_text;
      case 'wholesale':
        return localizations.wholesale_text;
      default:
        return type;
    }
  }
}
