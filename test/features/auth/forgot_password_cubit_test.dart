import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/model/otp_response.dart';
import 'package:mousa_store/features/auth/repo/otp_repo.dart';
import 'package:mousa_store/features/auth/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:mousa_store/features/auth/view_model/forgot_password_cubit/forgot_password_state.dart';

class MockOtpRepo extends Mock implements OtpRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockOtpRepo mockOtpRepo;

  setUp(() {
    mockOtpRepo = MockOtpRepo();
  });

  final sampleSuccessResponse = OtpResponse(
    success: true,
    message: 'Reset code sent to your email',
  );

  group('ForgotPasswordCubit Tests', () {
    test('initial state is default ForgotPasswordState', () async {
      final cubit = ForgotPasswordCubit(otpRepo: mockOtpRepo);
      expect(cubit.state.status, equals(ForgotPasswordStatus.initial));
      await cubit.close();
    });

    blocTest<ForgotPasswordCubit, ForgotPasswordState>(
      'emits [loading, success] when sendEmail succeeds',
      build: () {
        when(
          () =>
              mockOtpRepo.sendEmailForForgetPassword(email: 'user@example.com'),
        ).thenAnswer((_) async => sampleSuccessResponse);
        return ForgotPasswordCubit(otpRepo: mockOtpRepo);
      },
      act: (cubit) => cubit.sendEmail('user@example.com'),
      expect: () => [
        const ForgotPasswordState(
          status: ForgotPasswordStatus.loading,
          email: 'user@example.com',
        ),
        const ForgotPasswordState(
          status: ForgotPasswordStatus.success,
          email: 'user@example.com',
          message: 'Reset code sent to your email',
        ),
      ],
    );
  });
}
