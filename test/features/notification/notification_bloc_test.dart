import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/notification/data/models/notification_model.dart';
import 'package:mousa_store/features/notification/domain/usecases/get_notifications_use_case.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_event.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockGetNotificationsUseCase extends Mock
    implements GetNotificationsUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetNotificationsUseCase mockGetNotificationsUseCase;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockGetNotificationsUseCase = MockGetNotificationsUseCase();
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

  group('NotificationBloc Tests', () {
    test('initial state is default NotificationState', () async {
      final bloc = NotificationBloc(
        getNotificationsUseCase: mockGetNotificationsUseCase,
      );
      expect(bloc.state.status, equals(NotificationStatus.initial));
      await bloc.close();
    });

    blocTest<NotificationBloc, NotificationState>(
      'NotificationFetchRequested emits [loading, success] with notifications',
      build: () {
        when(
          () => mockGetNotificationsUseCase(page: any(named: 'page')),
        ).thenAnswer((_) async => sampleResult);
        return NotificationBloc(
          getNotificationsUseCase: mockGetNotificationsUseCase,
        );
      },
      act: (bloc) => bloc.add(const NotificationFetchRequested()),
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

    blocTest<NotificationBloc, NotificationState>(
      'NotificationFilterChanged updates selectedIndex and filteredNotifications',
      build: () {
        when(
          () => mockGetNotificationsUseCase(page: any(named: 'page')),
        ).thenAnswer((_) async => sampleResult);
        return NotificationBloc(
          getNotificationsUseCase: mockGetNotificationsUseCase,
        );
      },
      act: (bloc) async {
        bloc.add(const NotificationFetchRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const NotificationFilterChanged(1));
      },
      expect: () => [
        const NotificationState(status: NotificationStatus.loading),
        predicate<NotificationState>(
          (s) =>
              s.status == NotificationStatus.success &&
              s.selectedIndex == 0 &&
              s.filteredNotifications.length == 1,
        ),
        predicate<NotificationState>(
          (s) =>
              s.status == NotificationStatus.success &&
              s.selectedIndex == 1 &&
              s.filteredNotifications.length == 1,
        ),
      ],
    );
  });
}
