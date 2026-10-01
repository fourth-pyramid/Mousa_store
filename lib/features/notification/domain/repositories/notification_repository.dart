import 'package:mousa_store/features/notification/data/models/notification_model.dart';

abstract interface class NotificationRepository {
  Future<
    ({
      List<NotificationModel> notifications,
      int currentPage,
      int lastPage,
      int total,
    })
  >
  getNotifications({int page = 1});
}
