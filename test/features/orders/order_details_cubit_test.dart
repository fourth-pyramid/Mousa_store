import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/orders/model/order_details_model.dart';
import 'package:mousa_store/features/orders/repos/orders_repo.dart';
import 'package:mousa_store/features/orders/view_model/order_details_cubit/order_details_cubit.dart';
import 'package:mousa_store/features/orders/view_model/order_details_cubit/order_details_state.dart';

class MockOrdersRepo extends Mock implements OrdersRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockOrdersRepo mockOrdersRepo;

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
  });

  final sampleDetails = OrderDetailsData(
    order: OrderDetail(
      orderNumber: 'ORD-100',
      userName: 'Mousa',
      userPhone: '01000000000',
      userAddress: 'Cairo',
      status: 'completed',
      totalPrice: '250.0',
      createdAt: DateTime.parse('2026-08-18'),
      shipping: '20.0',
    ),
    product: [],
  );

  group('OrderDetailsCubit Tests', () {
    test('initial state is default OrderDetailsState', () async {
      final cubit = OrderDetailsCubit(mockOrdersRepo);
      expect(cubit.state.status, equals(OrderDetailsStatus.initial));
      await cubit.close();
    });

    blocTest<OrderDetailsCubit, OrderDetailsState>(
      'getOrderDetails emits [loading, success] with order details',
      build: () {
        when(() => mockOrdersRepo.getOrderDetails(100)).thenAnswer(
          (_) async => sampleDetails,
        );
        return OrderDetailsCubit(mockOrdersRepo);
      },
      act: (cubit) => cubit.getOrderDetails(100),
      expect: () => [
        const OrderDetailsState(status: OrderDetailsStatus.loading),
        OrderDetailsState(
          status: OrderDetailsStatus.success,
          orderDetails: sampleDetails,
        ),
      ],
    );
  });
}
