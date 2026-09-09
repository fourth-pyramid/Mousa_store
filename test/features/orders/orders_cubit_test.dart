import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/orders/model/order_model.dart';
import 'package:mousa_store/features/orders/repos/orders_repo.dart';
import 'package:mousa_store/features/orders/view_model/orders_cubit/orders_cubit.dart';
import 'package:mousa_store/features/orders/view_model/orders_cubit/orders_state.dart';

class MockOrdersRepo extends Mock implements OrdersRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockOrdersRepo mockOrdersRepo;

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
  });

  final sampleOrder = OrderModel(
    id: 100,
    orderNumber: 'ORD-100',
    status: 'completed',
    type: 'retail',
    createdAt: DateTime.parse('2026-08-18'),
  );

  group('OrdersCubit Tests', () {
    test('initial state is default OrdersState', () async {
      final cubit = OrdersCubit(mockOrdersRepo);
      expect(cubit.state.status, equals(OrdersStatus.initial));
      await cubit.close();
    });

    blocTest<OrdersCubit, OrdersState>(
      'getOrders emits [loading, success] with orders list',
      build: () {
        when(
          () => mockOrdersRepo.getOrders(),
        ).thenAnswer((_) async => [sampleOrder]);
        return OrdersCubit(mockOrdersRepo);
      },
      act: (cubit) => cubit.getOrders(),
      expect: () => [
        const OrdersState(status: OrdersStatus.loading),
        OrdersState(status: OrdersStatus.success, orders: [sampleOrder]),
      ],
    );
  });
}
