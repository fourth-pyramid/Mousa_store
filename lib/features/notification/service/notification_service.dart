import 'package:mousa_store/core/service/dio_helper.dart';

class NotificationService {
  Future<Map<String, dynamic>> getNotifications({int page = 1}) async {
    try {
      final response = await DioHelper.getData(
        url: 'notifications',
        query: {'page': page},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> markAsRead(int notificationId) async {
  //   try {
  //     await DioHelper.postData(
  //       url: 'notifications/$notificationId/read',
  //       data: {},
  //     );
  //   } catch (e) {
  //     // Silently fail - not critical if marking as read fails
  //   }
  // }
}
