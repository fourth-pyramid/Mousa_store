import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/notification/model/notification_model.dart';

enum NotificationStatus { initial, loading, success, failure }

class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const [],
    this.filteredNotifications = const [],
    this.selectedIndex = 0,
    this.allCount = 0,
    this.ordersCount = 0,
    this.offersCount = 0,
    this.alertsCount = 0,
    this.errorMessage,
    this.currentPage = 1,
    this.lastPage = 1,
    this.total = 0,
    this.isFetchingMore = false,
  });

  final NotificationStatus status;
  final List<NotificationModel> notifications;
  final List<NotificationModel> filteredNotifications;
  final int selectedIndex;
  final int allCount;
  final int ordersCount;
  final int offersCount;
  final int alertsCount;
  final String? errorMessage;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isFetchingMore;

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationModel>? notifications,
    List<NotificationModel>? filteredNotifications,
    int? selectedIndex,
    int? allCount,
    int? ordersCount,
    int? offersCount,
    int? alertsCount,
    String? errorMessage,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isFetchingMore,
  }) => NotificationState(
    status: status ?? this.status,
    notifications: notifications ?? this.notifications,
    filteredNotifications: filteredNotifications ?? this.filteredNotifications,
    selectedIndex: selectedIndex ?? this.selectedIndex,
    allCount: allCount ?? this.allCount,
    ordersCount: ordersCount ?? this.ordersCount,
    offersCount: offersCount ?? this.offersCount,
    alertsCount: alertsCount ?? this.alertsCount,
    errorMessage: errorMessage ?? this.errorMessage,
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    total: total ?? this.total,
    isFetchingMore: isFetchingMore ?? this.isFetchingMore,
  );

  @override
  List<Object?> get props => [
    status,
    notifications,
    filteredNotifications,
    selectedIndex,
    allCount,
    ordersCount,
    offersCount,
    alertsCount,
    errorMessage,
    currentPage,
    lastPage,
    total,
    isFetchingMore,
  ];
}
