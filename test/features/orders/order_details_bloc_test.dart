import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/orders/data/models/order_details_model.dart';
import 'package:mousa_store/features/orders/domain/usecases/orders_use_cases.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_bloc.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_event.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_state.dart';

class MockGetOrderDetailsUseCase extends Mock implements GetOrderDetailsUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetOrderDetailsUseCase mockGetOrderDetailsUseCase;

  setUp(() {
    mockGetOrderDetailsUseCase = MockGetOrderDetailsUseCase();
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
    product: const [],
  );

  group('OrderDetailsBloc Tests', () {
    test('initial state is default OrderDetailsState', () async {
      final bloc = OrderDetailsBloc(
        getOrderDetailsUseCase: mockGetOrderDetailsUseCase,
      );
      expect(bloc.state.status, equals(OrderDetailsStatus.initial));
      await bloc.close();
    });

    blocTest<OrderDetailsBloc, OrderDetailsState>(
      'OrderDetailsFetchRequested emits [loading, success] with order details',
      build: () {
        when(
          () => mockGetOrderDetailsUseCase(100),
        ).thenAnswer((_) async => sampleDetails);
        return OrderDetailsBloc(
          getOrderDetailsUseCase: mockGetOrderDetailsUseCase,
        );
      },
      act: (bloc) => bloc.add(const OrderDetailsFetchRequested(100)),
      expect: () => [
        const OrderDetailsState(status: OrderDetailsStatus.loading),
        OrderDetailsState(
          status: OrderDetailsStatus.success,
          orderDetails: sampleDetails,
        ),
      ],
    );

    blocTest<OrderDetailsBloc, OrderDetailsState>(
      'OrderDetailsFetchRequested emits [loading, failure] when error occurs',
      build: () {
        when(
          () => mockGetOrderDetailsUseCase(100),
        ).thenThrow(Exception('Order not found'));
        return OrderDetailsBloc(
          getOrderDetailsUseCase: mockGetOrderDetailsUseCase,
        );
      },
      act: (bloc) => bloc.add(const OrderDetailsFetchRequested(100)),
      expect: () => [
        const OrderDetailsState(status: OrderDetailsStatus.loading),
        const OrderDetailsState(
          status: OrderDetailsStatus.failure,
          errorMessage: 'Exception: Order not found',
        ),
      ],
    );
  });
}
