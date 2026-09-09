import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/model/login_response.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/auth/repo/login_repo.dart';
import 'package:mousa_store/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:mousa_store/features/auth/view_model/login_cubit/login_state.dart';

class MockLoginRepo extends Mock implements LoginRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginRepo mockLoginRepo;

  setUp(() {
    mockLoginRepo = MockLoginRepo();
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

  group('LoginCubit Tests', () {
    test('initial state is default LoginState', () async {
      final cubit = LoginCubit(loginRepo: mockLoginRepo);
      expect(cubit.state.status, equals(LoginStatus.initial));
      await cubit.close();
    });

    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] when login succeeds',
      build: () {
        when(
          () => mockLoginRepo.login(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenAnswer((_) async => sampleResponse);
        return LoginCubit(loginRepo: mockLoginRepo);
      },
      act: (cubit) =>
          cubit.login(email: 'test@example.com', password: 'password123'),
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        LoginState(status: LoginStatus.success, data: sampleResponse),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, failure] when login fails',
      build: () {
        when(
          () => mockLoginRepo.login(
            email: 'test@example.com',
            password: 'wrong_password',
          ),
        ).thenThrow(Exception('Invalid credentials'));
        return LoginCubit(loginRepo: mockLoginRepo);
      },
      act: (cubit) =>
          cubit.login(email: 'test@example.com', password: 'wrong_password'),
      expect: () => [
        const LoginState(status: LoginStatus.loading),
        predicate<LoginState>(
          (state) =>
              state.status == LoginStatus.failure &&
              state.error != null &&
              state.error!.contains('Invalid credentials'),
        ),
      ],
    );
  });
}
