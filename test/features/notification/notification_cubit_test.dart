import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/notification/model/notification_model.dart';
import 'package:mousa_store/features/notification/repo/notification_repo.dart';
import 'package:mousa_store/features/notification/view_model/notification_cubit.dart';
import 'package:mousa_store/features/notification/view_model/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationRepo extends Mock implements NotificationRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockNotificationRepo mockNotificationRepo;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockNotificationRepo = MockNotificationRepo();
  });

  final sampleNotification = NotificationModel(
    id: 1,
    title: 'Order Shipped',
    subtitle: 'Your order #100 has been shipped',
    time: DateTime.parse('2026-08-18'),
    type: NotificationType.orderStatus,
  );

  final sampleResult = (
    notifications: [sampleNotification],
    currentPage: 1,
    lastPage: 1,
    total: 1,
  );

  group('NotificationCubit Tests', () {
    test('initial state is default NotificationState', () async {
      final cubit = NotificationCubit(mockNotificationRepo);
      expect(cubit.state.status, equals(NotificationStatus.initial));
      await cubit.close();
    });

    blocTest<NotificationCubit, NotificationState>(
      'getNotifications emits [loading, success] with notifications',
      build: () {
        when(
          () => mockNotificationRepo.getNotifications(page: any(named: 'page')),
        ).thenAnswer((_) async => sampleResult);
        return NotificationCubit(mockNotificationRepo);
      },
      act: (cubit) => cubit.getNotifications(),
      expect: () => [
        const NotificationState(status: NotificationStatus.loading),
        predicate<NotificationState>(
          (s) =>
              s.status == NotificationStatus.success &&
              s.notifications.length == 1 &&
              s.ordersCount == 1,
        ),
      ],
    );
  });
}
