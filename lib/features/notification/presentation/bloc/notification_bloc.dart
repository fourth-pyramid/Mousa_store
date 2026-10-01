import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/notification/data/models/notification_model.dart';
import 'package:mousa_store/features/notification/domain/usecases/get_notifications_use_case.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_event.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required GetNotificationsUseCase getNotificationsUseCase})
      : _getNotificationsUseCase = getNotificationsUseCase,
        super(const NotificationState()) {
    on<NotificationFetchRequested>(_onNotificationFetchRequested);
    on<NotificationLoadMoreRequested>(_onNotificationLoadMoreRequested);
    on<NotificationFilterChanged>(_onNotificationFilterChanged);
    on<NotificationMarkReadRequested>(_onNotificationMarkReadRequested);

    unawaited(_loadReadNotifications());
  }

  final GetNotificationsUseCase _getNotificationsUseCase;
  bool _isFetching = false;
  final Set<int> _readNotificationIds = {};
  static const String _readNotificationsKey = 'read_notifications';

  Future<void> _loadReadNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final readIds = prefs.getStringList(_readNotificationsKey) ?? [];
      _readNotificationIds.addAll(readIds.map(int.parse));
    } on Object catch (_) {
      // Ignore errors loading preferences
    }
  }

  Future<void> _saveReadNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final readIds = _readNotificationIds.map((id) => id.toString()).toList();
      await prefs.setStringList(_readNotificationsKey, readIds);
    } on Object catch (_) {
      // Ignore errors saving preferences
    }
  }

  Future<void> _onNotificationFetchRequested(
    NotificationFetchRequested event,
    Emitter<NotificationState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    emit(state.copyWith(status: NotificationStatus.loading, currentPage: 1));

    try {
      final result = await _getNotificationsUseCase();
      emit(
        _createSuccessState(
          notifications: result.notifications,
          index: state.selectedIndex,
          currentPage: result.currentPage,
          lastPage: result.lastPage,
          total: result.total,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onNotificationLoadMoreRequested(
    NotificationLoadMoreRequested event,
    Emitter<NotificationState> emit,
  ) async {
    if (_isFetching || state.currentPage >= state.lastPage) return;
    _isFetching = true;

    emit(state.copyWith(isFetchingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final result = await _getNotificationsUseCase(page: nextPage);

      final updatedNotifications = List<NotificationModel>.from(
        state.notifications,
      )..addAll(result.notifications);

      emit(
        _createSuccessState(
          notifications: updatedNotifications,
          index: state.selectedIndex,
          currentPage: result.currentPage,
          lastPage: result.lastPage,
          total: result.total,
        ),
      );
    } on Object catch (_) {
      emit(state.copyWith(isFetchingMore: false));
    } finally {
      _isFetching = false;
    }
  }

  void _onNotificationFilterChanged(
    NotificationFilterChanged event,
    Emitter<NotificationState> emit,
  ) {
    emit(
      _createSuccessState(
        notifications: state.notifications,
        index: event.index,
        currentPage: state.currentPage,
        lastPage: state.lastPage,
        total: state.total,
      ),
    );
  }

  void _onNotificationMarkReadRequested(
    NotificationMarkReadRequested event,
    Emitter<NotificationState> emit,
  ) {
    _readNotificationIds.add(event.notificationId);
    unawaited(_saveReadNotifications());

    emit(
      state.copyWith(
        notifications: List.from(state.notifications),
        filteredNotifications: List.from(state.filteredNotifications),
      ),
    );
  }

  NotificationState _createSuccessState({
    required List<NotificationModel> notifications,
    required int index,
    required int currentPage,
    required int lastPage,
    required int total,
  }) {
    final filtered = _filterNotifications(notifications, index);
    return state.copyWith(
      status: NotificationStatus.success,
      notifications: notifications,
      filteredNotifications: filtered,
      selectedIndex: index,
      allCount: total,
      ordersCount: notifications
          .where((n) => n.type == NotificationType.orderStatus)
          .length,
      offersCount: notifications
          .where(
            (n) =>
                n.type == NotificationType.cartOffer ||
                n.type == NotificationType.favoriteOffer ||
                n.type == NotificationType.specialOffer,
          )
          .length,
      alertsCount: notifications
          .where(
            (n) =>
                n.type == NotificationType.lowStock ||
                n.type == NotificationType.lowStockFavorite ||
                n.type == NotificationType.limitedStock,
          )
          .length,
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
      isFetchingMore: false,
    );
  }

  List<NotificationModel> _filterNotifications(
    List<NotificationModel> notifications,
    int index,
  ) {
    if (index == 0) return notifications;
    return notifications.where((notification) {
      if (index == 1) {
        return notification.type == NotificationType.orderStatus;
      }
      if (index == 2) {
        return notification.type == NotificationType.cartOffer ||
            notification.type == NotificationType.favoriteOffer ||
            notification.type == NotificationType.specialOffer;
      }
      if (index == 3) {
        return notification.type == NotificationType.lowStock ||
            notification.type == NotificationType.lowStockFavorite ||
            notification.type == NotificationType.limitedStock;
      }
      return true;
    }).toList();
  }

  // Compatibility helpers
  Future<void> getNotifications() async {
    add(const NotificationFetchRequested());
  }

  Future<void> loadMoreNotifications() async {
    add(const NotificationLoadMoreRequested());
  }

  void setSelectedIndex(int index) {
    add(NotificationFilterChanged(index));
  }

  void markAsReadLocally(int notificationId) {
    add(NotificationMarkReadRequested(notificationId));
  }

  bool isNotificationRead(int notificationId) =>
      _readNotificationIds.contains(notificationId);
}
