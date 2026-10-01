import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_state.dart';
import 'package:mousa_store/features/notification/presentation/widgets/notification_list.dart';
import 'package:mousa_store/features/notification/presentation/widgets/notification_tab.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final bloc = getIt<NotificationBloc>();
      unawaited(bloc.getNotifications());
      return bloc;
    },
    child: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.notifications_text.toUpperCase()),
        ),
        body: InternetStateManager(
          noInternetScreen: const NoInternetScreen(),
          onRestoreInternetConnection: () =>
              unawaited(context.read<NotificationBloc>().getNotifications()),
          child: BlocBuilder<NotificationBloc, NotificationState>(
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
                        return (
                          index: 0,
                          all: 0,
                          orders: 0,
                          offers: 0,
                          alerts: 0,
                        );
                      },
                      builder: (context, data) => NotificationTabs(
                        selectedIndex: data.index,
                        allCount: data.all,
                        ordersCount: data.orders,
                        offersCount: data.offers,
                        alertsCount: data.alerts,
                        onChanged: (index) {
                          context.read<NotificationBloc>().setSelectedIndex(
                            index,
                          );
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
      ),
    ),
  );
}
