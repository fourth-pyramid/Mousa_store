import 'package:mousa_store/core/utils/json_parsers.dart';
import 'package:mousa_store/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:mousa_store/features/notification/data/models/notification_model.dart';
import 'package:mousa_store/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl({
    required NotificationRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final NotificationRemoteDataSource _remoteDataSource;

  @override
  Future<
    ({
      List<NotificationModel> notifications,
      int currentPage,
      int lastPage,
      int total,
    })
  >
  getNotifications({int page = 1}) async {
    final response = await _remoteDataSource.getNotifications(page: page);
    final rawData = response['data'];

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
      currentPage = JsonParsers.toInt(rawData['current_page'], fallback: page);
      lastPage = JsonParsers.toInt(rawData['last_page'], fallback: 1);
      total = JsonParsers.toInt(rawData['total'], fallback: data.length);
    } else {
      data = [];
      currentPage = page;
      lastPage = 1;
      total = 0;
    }

    final notifications = data
        .whereType<Map<String, dynamic>>()
        .map(NotificationModel.fromJson)
        .toList();

    return (
      notifications: notifications,
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
    );
  }
}
