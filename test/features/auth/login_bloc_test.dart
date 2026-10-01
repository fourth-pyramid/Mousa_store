import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/data/models/login_response.dart';
import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/auth/domain/entities/auth_exceptions.dart';
import 'package:mousa_store/features/auth/domain/usecases/login_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/login_bloc.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  final sampleUser = User(
    id: 1,
    firstName: 'Test',
    lastName: 'User',
    email: 'test@example.com',
    phone: '01000000000',
    userType: 'customer',
    isVerified: true,
  );

  final sampleResponse = LoginResponse(
    status: 'success',
    message: 'Login successful',
    token: 'fake_jwt_token',
    user: sampleUser,
  );

  group('LoginBloc Tests', () {
    test('initial state is LoginInitial', () async {
      final bloc = LoginBloc(loginUseCase: mockLoginUseCase);
      expect(bloc.state, isA<LoginInitial>());
      await bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      build: () {
        when(
          () => mockLoginUseCase(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenAnswer((_) async => sampleResponse);
        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        const LoginEvent.submitted(
          email: 'test@example.com',
          password: 'password123',
        ),
      ),
      expect: () => [
        const LoginState.loading(),
        LoginState.success(sampleResponse),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginEmailNotVerified] when email is not verified',
      build: () {
        when(
          () => mockLoginUseCase(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenThrow(const EmailNotVerifiedException('Please verify email'));
        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        const LoginEvent.submitted(
          email: 'test@example.com',
          password: 'password123',
        ),
      ),
      expect: () => [
        const LoginState.loading(),
        const LoginState.emailNotVerified(message: 'Please verify email'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when an error occurs',
      build: () {
        when(
          () => mockLoginUseCase(
            email: 'test@example.com',
            password: 'wrong_password',
          ),
        ).thenThrow(Exception('Invalid credentials'));
        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) => bloc.add(
        const LoginEvent.submitted(
          email: 'test@example.com',
          password: 'wrong_password',
        ),
      ),
      expect: () => [
        const LoginState.loading(),
        predicate<LoginState>(
          (state) =>
              state is LoginFailure &&
              state.error.contains('Invalid credentials'),
        ),
      ],
    );
  });
}
