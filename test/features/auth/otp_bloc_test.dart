import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/otp_bloc.dart';

class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}

class MockResendOtpUseCase extends Mock implements ResendOtpUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockVerifyOtpUseCase mockVerifyOtpUseCase;
  late MockResendOtpUseCase mockResendOtpUseCase;

  setUp(() {
    mockVerifyOtpUseCase = MockVerifyOtpUseCase();
    mockResendOtpUseCase = MockResendOtpUseCase();
  });

  final sampleOtpResponse = OtpResponse(
    success: true,
    message: 'OTP verified successfully',
    token: 'reset_token_abc',
  );

  group('OtpBloc Tests', () {
    test('initial state has correct default values', () async {
      final bloc = OtpBloc(
        verifyOtpUseCase: mockVerifyOtpUseCase,
        resendOtpUseCase: mockResendOtpUseCase,
        flowType: OtpFlowType.signup,
      );
      expect(bloc.state.status, equals(OtpStatus.idle));
      expect(bloc.state.flowType, equals(OtpFlowType.signup));
      expect(bloc.state.remainingSeconds, equals(0));
      await bloc.close();
    });

    blocTest<OtpBloc, OtpState>(
      'updates otpCode when codeChanged event is added',
      build: () => OtpBloc(
        verifyOtpUseCase: mockVerifyOtpUseCase,
        resendOtpUseCase: mockResendOtpUseCase,
        flowType: OtpFlowType.signup,
      ),
      act: (bloc) => bloc.add(const OtpEvent.codeChanged('123456')),
      expect: () => [
        const OtpState(otpCode: '123456'),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'updates remainingSeconds when timerTicked event is added',
      build: () => OtpBloc(
        verifyOtpUseCase: mockVerifyOtpUseCase,
        resendOtpUseCase: mockResendOtpUseCase,
        flowType: OtpFlowType.signup,
      ),
      act: (bloc) => bloc.add(const OtpEvent.timerTicked(30)),
      expect: () => [
        const OtpState(remainingSeconds: 30),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, success] when verify succeeds',
      build: () {
        when(
          () => mockVerifyOtpUseCase.verifySignupOtp(
            email: 'test@example.com',
            otp: '123456',
          ),
        ).thenAnswer((_) async => sampleOtpResponse);
        return OtpBloc(
          verifyOtpUseCase: mockVerifyOtpUseCase,
          resendOtpUseCase: mockResendOtpUseCase,
          flowType: OtpFlowType.signup,
        );
      },
      act: (bloc) {
        bloc
          ..add(const OtpEvent.codeChanged('123456'))
          ..add(const OtpEvent.verifySubmitted(email: 'test@example.com'));
      },
      expect: () => [
        const OtpState(otpCode: '123456'),
        const OtpState(
          status: OtpStatus.loading,
          otpCode: '123456',
        ),
        const OtpState(
          status: OtpStatus.success,
          otpCode: '123456',
          message: 'OTP verified successfully',
          resetToken: 'reset_token_abc',
        ),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, error] when verify fails',
      build: () {
        when(
          () => mockVerifyOtpUseCase.verifySignupOtp(
            email: 'test@example.com',
            otp: '000000',
          ),
        ).thenThrow(Exception('Invalid OTP code'));
        return OtpBloc(
          verifyOtpUseCase: mockVerifyOtpUseCase,
          resendOtpUseCase: mockResendOtpUseCase,
          flowType: OtpFlowType.signup,
        );
      },
      act: (bloc) {
        bloc
          ..add(const OtpEvent.codeChanged('000000'))
          ..add(const OtpEvent.verifySubmitted(email: 'test@example.com'));
      },
      expect: () => [
        const OtpState(otpCode: '000000'),
        const OtpState(
          status: OtpStatus.loading,
          otpCode: '000000',
        ),
        predicate<OtpState>(
          (state) =>
              state.status == OtpStatus.error &&
              state.message.contains('Invalid OTP code'),
        ),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, success] when resend succeeds',
      build: () {
        when(
          () => mockResendOtpUseCase.resendSignupOtp(
            email: 'test@example.com',
          ),
        ).thenAnswer((_) async => sampleOtpResponse);
        return OtpBloc(
          verifyOtpUseCase: mockVerifyOtpUseCase,
          resendOtpUseCase: mockResendOtpUseCase,
          flowType: OtpFlowType.signup,
        );
      },
      act: (bloc) => bloc.add(
        const OtpEvent.resendSubmitted(email: 'test@example.com'),
      ),
      expect: () => [
        const OtpState(
          status: OtpStatus.loading,
        ),
        const OtpState(
          status: OtpStatus.success,
          message: 'OTP verified successfully',
        ),
        const OtpState(
          status: OtpStatus.success,
          remainingSeconds: 600,
          message: 'OTP verified successfully',
        ),
      ],
    );
  });
}
