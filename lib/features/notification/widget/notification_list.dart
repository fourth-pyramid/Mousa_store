import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/features/notification/view_model/notification_cubit.dart';
import 'package:mousa_store/features/notification/view_model/notification_state.dart';
import 'package:mousa_store/features/notification/widget/notification_item.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      unawaited(context.read<NotificationCubit>().loadMoreNotifications());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotificationCubit, NotificationState>(
        buildWhen: (previous, current) =>
            previous.filteredNotifications != current.filteredNotifications ||
            previous.status != current.status ||
            previous.isFetchingMore != current.isFetchingMore,
        builder: (context, state) {
          final filtered = state.filteredNotifications;
          if (filtered.isEmpty && state.status == NotificationStatus.success) {
            return AppEmptyState(
              title: context.l10n.notifications_text,
              description: context.l10n.no_notifications_message_text,
              icon: Icons.notifications_none_rounded,
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: filtered.length + 1,
            itemBuilder: (context, index) {
              if (index == filtered.length) {
                if (state.isFetchingMore) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state.currentPage >= state.lastPage &&
                    filtered.isNotEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 16.h),
                      const _NotificationCaughtUpIndicator(),
                      SizedBox(height: 24.h),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }
              final n = filtered[index];
              return NotificationItem(key: ValueKey(n.id), notification: n);
            },
          );
        },
      );
}

class _NotificationCaughtUpIndicator extends StatelessWidget {
  const _NotificationCaughtUpIndicator();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      children: [
        SizedBox(
          width: 56.w,
          height: 56.w,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: context.colors.primary.withValues(alpha: 0.3),
                  blurRadius: 15.r,
                ),
              ],
            ),
            child: Icon(
              Icons.check,
              color: context.colors.textPrimary,
              size: 28.w,
            ),
          ),
        ),

        SizedBox(height: 12.h),
        Text(
          context.l10n.all_caught_up_message_text,
          style: context.typography.bodySmall.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
