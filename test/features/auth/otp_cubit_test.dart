import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/model/otp_response.dart';
import 'package:mousa_store/features/auth/repo/otp_repo.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_cubit.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_state.dart';

class MockOtpRepo extends Mock implements OtpRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockOtpRepo mockOtpRepo;

  setUp(() {
    mockOtpRepo = MockOtpRepo();
  });

  final sampleOtpSuccess = OtpResponse(
    success: true,
    message: 'OTP verified successfully',
    token: 'reset_token_xyz',
  );

  group('OtpCubit Tests', () {
    test('initial state sets flowType correctly', () async {
      final cubit = OtpCubit(
        otpRepo: mockOtpRepo,
        flowType: OtpFlowType.signup,
      );
      expect(cubit.state.flowType, equals(OtpFlowType.signup));
      expect(cubit.state.status, equals(OtpStatus.idle));
      await cubit.close();
    });

    test('setOtpCode updates otpCode in state', () async {
      final cubit = OtpCubit(otpRepo: mockOtpRepo, flowType: OtpFlowType.signup)
        ..setOtpCode('1234');
      expect(cubit.state.otpCode, equals('1234'));
      await cubit.close();
    });

    blocTest<OtpCubit, OtpState>(
      'emits [loading, success] when verifyOtp succeeds for signup',
      build: () {
        when(
          () => mockOtpRepo.verifyOtp(email: 'test@example.com', otp: '1234'),
        ).thenAnswer((_) async => sampleOtpSuccess);
        return OtpCubit(otpRepo: mockOtpRepo, flowType: OtpFlowType.signup)
          ..setOtpCode('1234');
      },
      act: (cubit) => cubit.verifyOtp('test@example.com'),
      expect: () => [
        const OtpState(otpCode: '1234', status: OtpStatus.loading),
        const OtpState(
          otpCode: '1234',
          status: OtpStatus.success,
          message: 'OTP verified successfully',
          resetToken: 'reset_token_xyz',
        ),
      ],
    );
  });
}
