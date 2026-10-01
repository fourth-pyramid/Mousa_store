import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/data/models/otp_response.dart';
import 'package:mousa_store/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/forgot_password_bloc.dart';

class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockForgotPasswordUseCase mockForgotPasswordUseCase;

  setUp(() {
    mockForgotPasswordUseCase = MockForgotPasswordUseCase();
  });

  final sampleResponse = OtpResponse(
    success: true,
    message: 'Reset code sent',
  );

  group('ForgotPasswordBloc Tests', () {
    test('initial state is ForgotPasswordInitial', () async {
      final bloc = ForgotPasswordBloc(
        forgotPasswordUseCase: mockForgotPasswordUseCase,
      );
      expect(bloc.state, isA<ForgotPasswordInitial>());
      await bloc.close();
    });

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'emits [Loading, Success] when forgot password succeeds',
      build: () {
        when(
          () => mockForgotPasswordUseCase(email: 'test@example.com'),
        ).thenAnswer((_) async => sampleResponse);
        return ForgotPasswordBloc(
          forgotPasswordUseCase: mockForgotPasswordUseCase,
        );
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent.submitted(email: 'test@example.com'),
      ),
      expect: () => [
        const ForgotPasswordState.loading(),
        ForgotPasswordState.success(
          response: sampleResponse,
          email: 'test@example.com',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'emits [Loading, Failure] when forgot password fails',
      build: () {
        when(
          () => mockForgotPasswordUseCase(email: 'test@example.com'),
        ).thenThrow(Exception('User not found'));
        return ForgotPasswordBloc(
          forgotPasswordUseCase: mockForgotPasswordUseCase,
        );
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent.submitted(email: 'test@example.com'),
      ),
      expect: () => [
        const ForgotPasswordState.loading(),
        predicate<ForgotPasswordState>(
          (state) =>
              state is ForgotPasswordFailure &&
              state.message.contains('User not found'),
        ),
      ],
    );
  });
}
