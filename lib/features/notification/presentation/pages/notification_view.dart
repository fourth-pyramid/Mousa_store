import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_state.dart';
import 'package:mousa_store/features/notification/presentation/widgets/notification_list.dart';
import 'package:mousa_store/features/notification/presentation/widgets/notification_tab.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late final NotificationBloc _bloc;
  StreamSubscription<void>? _networkRestoreSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<NotificationBloc>();
    unawaited(_bloc.getNotifications());
    _networkRestoreSubscription = getIt<InternetConnectionService>()
        .connectivityRestoredStream
        .listen((_) {
          if (mounted) {
            unawaited(_bloc.getNotifications());
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
        title: Text(context.l10n.notifications_text.toUpperCase()),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == NotificationStatus.loading) {
            return const Center(child: CustomLoadingIndicator());
          } else if (state.status == NotificationStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? '',
                style: context.typography.bodySmall.copyWith(
                  color: context.colors.error,
                ),
              ),
            );
          } else if (state.status == NotificationStatus.success) {
            return Column(
              children: [
                BlocSelector<
                  NotificationBloc,
                  NotificationState,
                  ({int index, int all, int orders, int offers, int alerts})
                >(
                  selector: (state) {
                    if (state.status == NotificationStatus.success) {
                      return (
                        index: state.selectedIndex,
                        all: state.allCount,
                        orders: state.ordersCount,
                        offers: state.offersCount,
                        alerts: state.alertsCount,
                      );
                    }
                    return (index: 0, all: 0, orders: 0, offers: 0, alerts: 0);
                  },
                  builder: (context, data) => NotificationTabs(
                    selectedIndex: data.index,
                    allCount: data.all,
                    ordersCount: data.orders,
                    offersCount: data.offers,
                    alertsCount: data.alerts,
                    onChanged: (index) {
                      context.read<NotificationBloc>().setSelectedIndex(index);
                    },
                  ),
                ),
                const Expanded(child: NotificationList()),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
  );
}
