import 'package:mousa_store/core/service/dio_helper.dart';

abstract interface class NotificationRemoteDataSource {
  Future<Map<String, dynamic>> getNotifications({int page = 1});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl();

  @override
  Future<Map<String, dynamic>> getNotifications({int page = 1}) async {
    final response = await DioHelper.getData(
      url: 'notifications',
      query: {'page': page},
    );
    return response.data as Map<String, dynamic>;
  }
}
