import 'package:mousa_store/features/notification/data/models/notification_model.dart';
import 'package:mousa_store/features/notification/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  Future<
    ({
      List<NotificationModel> notifications,
      int currentPage,
      int lastPage,
      int total,
    })
  >
  call({int page = 1}) => _repository.getNotifications(page: page);
}
