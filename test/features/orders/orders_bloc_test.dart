import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/orders/data/models/order_model.dart';
import 'package:mousa_store/features/orders/domain/usecases/orders_use_cases.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_event.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_state.dart';

class MockGetOrdersUseCase extends Mock implements GetOrdersUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetOrdersUseCase mockGetOrdersUseCase;

  setUp(() {
    mockGetOrdersUseCase = MockGetOrdersUseCase();
  });

  final sampleOrder = OrderModel(
    id: 100,
    orderNumber: 'ORD-100',
    status: 'completed',
    type: 'retail',
    createdAt: DateTime.parse('2026-08-18'),
  );

  group('OrdersBloc Tests', () {
    test('initial state is default OrdersState', () async {
      final bloc = OrdersBloc(getOrdersUseCase: mockGetOrdersUseCase);
      expect(bloc.state.status, equals(OrdersStatus.initial));
      await bloc.close();
    });

    blocTest<OrdersBloc, OrdersState>(
      'OrdersFetchRequested emits [loading, success] with orders list',
      build: () {
        when(() => mockGetOrdersUseCase()).thenAnswer((_) async => [sampleOrder]);
        return OrdersBloc(getOrdersUseCase: mockGetOrdersUseCase);
      },
      act: (bloc) => bloc.add(const OrdersFetchRequested()),
      expect: () => [
        const OrdersState(status: OrdersStatus.loading),
        OrdersState(status: OrdersStatus.success, orders: [sampleOrder]),
      ],
    );

    blocTest<OrdersBloc, OrdersState>(
      'OrdersSearchQueryChanged filters cached orders by orderNumber',
      build: () {
        when(() => mockGetOrdersUseCase()).thenAnswer((_) async => [sampleOrder]);
        return OrdersBloc(getOrdersUseCase: mockGetOrdersUseCase);
      },
      act: (bloc) async {
        bloc.add(const OrdersFetchRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const OrdersSearchQueryChanged('NON_EXISTENT'));
      },
      expect: () => [
        const OrdersState(status: OrdersStatus.loading),
        OrdersState(status: OrdersStatus.success, orders: [sampleOrder]),
        const OrdersState(status: OrdersStatus.success),
      ],
    );
  });
}
