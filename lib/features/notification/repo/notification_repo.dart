import 'package:mousa_store/features/notification/model/notification_model.dart';
import 'package:mousa_store/features/notification/service/notification_service.dart';

class NotificationRepo {
  NotificationRepo(this._service);
  final NotificationService _service;

  Future<({List<NotificationModel> notifications, int currentPage, int lastPage, int total})> getNotifications({
    int page = 1,
  }) async {
    try {
      final response = await _service.getNotifications(page: page);
      final rawData = response['data']; // ponytail: handle both List and Map responses

      final List<dynamic> data;
      final int currentPage;
      final int lastPage;
      final int total;

      if (rawData is List) {
        data = rawData;
        currentPage = page;
        lastPage = 1;
        total = rawData.length;
      } else if (rawData is Map<String, dynamic>) {
        data = (rawData['data'] as List<dynamic>?) ?? [];
        currentPage = (rawData['current_page'] as num?)?.toInt() ?? page;
        lastPage = (rawData['last_page'] as num?)?.toInt() ?? 1;
        total = (rawData['total'] as num?)?.toInt() ?? data.length;
      } else {
        data = [];
        currentPage = page;
        lastPage = 1;
        total = 0;
      }

      final notifications = data.whereType<Map<String, dynamic>>().map(NotificationModel.fromJson).toList();

      return (notifications: notifications, currentPage: currentPage, lastPage: lastPage, total: total);
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> markAsRead(int notificationId) async {
  //   await _service.markAsRead(notificationId);
  // }
}
