import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/enums/request_status.dart';
import 'package:mousa_store/features/cart/repositories/checkout_repo.dart';
import 'package:mousa_store/features/cart/viewmodels/checkout_cubit.dart';

class MockCheckoutRepo extends Mock implements CheckoutRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCheckoutRepo mockCheckoutRepo;

  setUp(() {
    mockCheckoutRepo = MockCheckoutRepo();
  });

  group('CheckoutCubit Tests', () {
    test('initial state is default CheckoutState', () async {
      final cubit = CheckoutCubit(mockCheckoutRepo);
      expect(cubit.state.checkoutStatus, equals(RequestStatus.initial));
      await cubit.close();
    });

    blocTest<CheckoutCubit, CheckoutState>(
      'checkout emits [loading, success] with message',
      build: () {
        when(
          () => mockCheckoutRepo.checkout(
            userAddress: 'Cairo, Egypt',
            userName: 'Mousa',
            userPhone: '01000000000',
            governorateId: 1,
          ),
        ).thenAnswer((_) async => 'Order placed successfully');
        return CheckoutCubit(mockCheckoutRepo);
      },
      act: (cubit) => cubit.checkout(
        userAddress: 'Cairo, Egypt',
        userName: 'Mousa',
        userPhone: '01000000000',
        governorateId: 1,
      ),
      expect: () => [
        const CheckoutState(checkoutStatus: RequestStatus.loading),
        const CheckoutState(
          checkoutStatus: RequestStatus.success,
          message: 'Order placed successfully',
        ),
      ],
    );
  });
}
