import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/model/otp_response.dart';
import 'package:mousa_store/features/auth/repo/reset_password_repo.dart';
import 'package:mousa_store/features/auth/view_model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mousa_store/features/auth/view_model/reset_password_cubit/reset_password_state.dart';

class MockResetPasswordRepo extends Mock implements ResetPasswordRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockResetPasswordRepo mockResetPasswordRepo;

  setUp(() {
    mockResetPasswordRepo = MockResetPasswordRepo();
  });

  final sampleSuccess = OtpResponse(
    success: true,
    message: 'Password reset successfully',
  );

  group('ResetPasswordCubit Tests', () {
    test('initial state is default ResetPasswordState', () async {
      final cubit = ResetPasswordCubit(
        resetPasswordRepo: mockResetPasswordRepo,
      );
      expect(cubit.state.status, equals(ResetPasswordStatus.idle));
      await cubit.close();
    });

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits failure if passwords do not match',
      build: () => ResetPasswordCubit(resetPasswordRepo: mockResetPasswordRepo),
      act: (cubit) => cubit.resetPassword(
        email: 'user@example.com',
        newPassword: 'pass1',
        confirmPassword: 'pass2',
        resetToken: 'token123',
      ),
      expect: () => [
        const ResetPasswordState(
          status: ResetPasswordStatus.failure,
          message: 'Passwords do not match',
        ),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [loading, success] when password matches and reset succeeds',
      build: () {
        when(
          () => mockResetPasswordRepo.resetPassword(
            email: 'user@example.com',
            newPassword: 'newPassword123',
            passwordConfirm: 'newPassword123',
            resetToken: 'token123',
          ),
        ).thenAnswer((_) async => sampleSuccess);
        return ResetPasswordCubit(resetPasswordRepo: mockResetPasswordRepo);
      },
      act: (cubit) => cubit.resetPassword(
        email: 'user@example.com',
        newPassword: 'newPassword123',
        confirmPassword: 'newPassword123',
        resetToken: 'token123',
      ),
      expect: () => [
        const ResetPasswordState(status: ResetPasswordStatus.loading),
        const ResetPasswordState(
          status: ResetPasswordStatus.success,
          message: 'Password reset successfully',
        ),
      ],
    );
  });
}
