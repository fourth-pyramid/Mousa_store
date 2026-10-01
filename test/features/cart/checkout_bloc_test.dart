import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/domain/usecases/checkout_use_cases.dart';
import 'package:mousa_store/features/cart/presentation/bloc/checkout_bloc.dart';

class MockCheckoutUseCase extends Mock implements CheckoutUseCase {}

class MockGetShippingFeeUseCase extends Mock implements GetShippingFeeUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCheckoutUseCase mockCheckoutUseCase;
  late MockGetShippingFeeUseCase mockGetShippingFeeUseCase;

  setUp(() {
    mockCheckoutUseCase = MockCheckoutUseCase();
    mockGetShippingFeeUseCase = MockGetShippingFeeUseCase();
  });

  CheckoutBloc createBloc() => CheckoutBloc(
    checkoutUseCase: mockCheckoutUseCase,
    getShippingFeeUseCase: mockGetShippingFeeUseCase,
  );

  group('CheckoutBloc Tests', () {
    test('initial state is default CheckoutState', () async {
      final bloc = createBloc();
      expect(bloc.state.checkoutStatus, equals(RequestStatus.initial));
      await bloc.close();
    });

    blocTest<CheckoutBloc, CheckoutState>(
      'checkout emits [loading, success] with message',
      build: () {
        when(
          () => mockCheckoutUseCase(
            userAddress: 'Cairo, Egypt',
            userName: 'Mousa',
            userPhone: '01000000000',
            governorateId: 1,
          ),
        ).thenAnswer((_) async => 'Order placed successfully');
        return createBloc();
      },
      act: (bloc) => bloc.add(
        const CheckoutSubmitted(
          userAddress: 'Cairo, Egypt',
          userName: 'Mousa',
          userPhone: '01000000000',
          governorateId: 1,
        ),
      ),
      expect: () => [
        const CheckoutState(checkoutStatus: RequestStatus.loading),
        const CheckoutState(
          checkoutStatus: RequestStatus.success,
          message: 'Order placed successfully',
        ),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'getShippingFee emits [loading, success] with fee',
      build: () {
        when(
          () => mockGetShippingFeeUseCase(governorateId: 1),
        ).thenAnswer((_) async => '50');
        return createBloc();
      },
      act: (bloc) => bloc.add(const ShippingFeeRequested(governorateId: 1)),
      expect: () => [
        const CheckoutState(shippingFeeStatus: RequestStatus.loading),
        const CheckoutState(
          shippingFeeStatus: RequestStatus.success,
          shippingFee: '50',
        ),
      ],
    );
  });
}
