import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/data/models/signup_response.dart';
import 'package:mousa_store/features/auth/domain/usecases/signup_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/signup_bloc.dart';

class MockSignupUseCase extends Mock implements SignupUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSignupUseCase mockSignupUseCase;

  setUp(() {
    mockSignupUseCase = MockSignupUseCase();
  });

  final sampleResponse = SignupResponse(
    success: true,
    message: 'User created successfully',
  );

  group('SignupBloc Tests', () {
    test('initial state is SignupInitial', () async {
      final bloc = SignupBloc(signupUseCase: mockSignupUseCase);
      expect(bloc.state, isA<SignupInitial>());
      await bloc.close();
    });

    blocTest<SignupBloc, SignupState>(
      'emits [SignupLoading, SignupSuccess] when signup succeeds',
      build: () {
        when(
          () => mockSignupUseCase(
            firstName: 'Test',
            lastName: 'User',
            email: 'test@example.com',
            phone: '01000000000',
            password: 'password123',
            passwordConfirmation: 'password123',
          ),
        ).thenAnswer((_) async => sampleResponse);
        return SignupBloc(signupUseCase: mockSignupUseCase);
      },
      act: (bloc) => bloc.add(
        const SignupEvent.submitted(
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          phone: '01000000000',
          password: 'password123',
          passwordConfirmation: 'password123',
        ),
      ),
      expect: () => [
        const SignupState.loading(),
        SignupState.success(sampleResponse),
      ],
    );

    blocTest<SignupBloc, SignupState>(
      'emits [SignupLoading, SignupFailure] when signup fails',
      build: () {
        when(
          () => mockSignupUseCase(
            firstName: 'Test',
            lastName: 'User',
            email: 'test@example.com',
            phone: '01000000000',
            password: 'password123',
            passwordConfirmation: 'password123',
          ),
        ).thenThrow(Exception('Email already registered'));
        return SignupBloc(signupUseCase: mockSignupUseCase);
      },
      act: (bloc) => bloc.add(
        const SignupEvent.submitted(
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          phone: '01000000000',
          password: 'password123',
          passwordConfirmation: 'password123',
        ),
      ),
      expect: () => [
        const SignupState.loading(),
        predicate<SignupState>(
          (state) =>
              state is SignupFailure &&
              state.error.contains('Email already registered'),
        ),
      ],
    );
  });
}
