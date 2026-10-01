import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/notification/data/models/notification_model.dart';

part 'notification_state.freezed.dart';

enum NotificationStatus { initial, loading, success, failure }

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(NotificationStatus.initial) NotificationStatus status,
    @Default([]) List<NotificationModel> notifications,
    @Default([]) List<NotificationModel> filteredNotifications,
    @Default(0) int selectedIndex,
    @Default(0) int allCount,
    @Default(0) int ordersCount,
    @Default(0) int offersCount,
    @Default(0) int alertsCount,
    String? errorMessage,
    @Default(1) int currentPage,
    @Default(1) int lastPage,
    @Default(0) int total,
    @Default(false) bool isFetchingMore,
  }) = _NotificationState;
}
