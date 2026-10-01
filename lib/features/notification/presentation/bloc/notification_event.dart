import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.freezed.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.fetchRequested() = NotificationFetchRequested;
  const factory NotificationEvent.loadMoreRequested() =
      NotificationLoadMoreRequested;
  const factory NotificationEvent.filterChanged(int index) =
      NotificationFilterChanged;
  const factory NotificationEvent.markReadRequested(int notificationId) =
      NotificationMarkReadRequested;
}
