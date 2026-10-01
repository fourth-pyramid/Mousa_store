import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/reset_password_bloc.dart';

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUp(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
  });

  final sampleResponse = OtpResponse(
    success: true,
    message: 'Password reset successfully',
  );

  group('ResetPasswordBloc Tests', () {
    test('initial state is ResetPasswordInitial', () async {
      final bloc = ResetPasswordBloc(
        resetPasswordUseCase: mockResetPasswordUseCase,
      );
      expect(bloc.state, isA<ResetPasswordInitial>());
      await bloc.close();
    });

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits [ResetPasswordFailure] when passwords do not match',
      build: () => ResetPasswordBloc(
        resetPasswordUseCase: mockResetPasswordUseCase,
      ),
      act: (bloc) => bloc.add(
        const ResetPasswordEvent.submitted(
          email: 'test@example.com',
          newPassword: 'password123',
          passwordConfirm: 'password999',
          resetToken: 'token123',
        ),
      ),
      expect: () => [
        const ResetPasswordState.failure('Passwords do not match'),
      ],
    );

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits [Loading, Success] when reset password succeeds',
      build: () {
        when(
          () => mockResetPasswordUseCase(
            email: 'test@example.com',
            newPassword: 'password123',
            passwordConfirm: 'password123',
            resetToken: 'token123',
          ),
        ).thenAnswer((_) async => sampleResponse);
        return ResetPasswordBloc(
          resetPasswordUseCase: mockResetPasswordUseCase,
        );
      },
      act: (bloc) => bloc.add(
        const ResetPasswordEvent.submitted(
          email: 'test@example.com',
          newPassword: 'password123',
          passwordConfirm: 'password123',
          resetToken: 'token123',
        ),
      ),
      expect: () => [
        const ResetPasswordState.loading(),
        ResetPasswordState.success(sampleResponse),
      ],
    );

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits [Loading, Failure] when reset password fails',
      build: () {
        when(
          () => mockResetPasswordUseCase(
            email: 'test@example.com',
            newPassword: 'password123',
            passwordConfirm: 'password123',
            resetToken: 'token123',
          ),
        ).thenThrow(Exception('Invalid or expired token'));
        return ResetPasswordBloc(
          resetPasswordUseCase: mockResetPasswordUseCase,
        );
      },
      act: (bloc) => bloc.add(
        const ResetPasswordEvent.submitted(
          email: 'test@example.com',
          newPassword: 'password123',
          passwordConfirm: 'password123',
          resetToken: 'token123',
        ),
      ),
      expect: () => [
        const ResetPasswordState.loading(),
        predicate<ResetPasswordState>(
          (state) =>
              state is ResetPasswordFailure &&
              state.message.contains('Invalid or expired token'),
        ),
      ],
    );
  });
}
