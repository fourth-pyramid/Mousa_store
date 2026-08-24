import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/model/signup_response.dart';
import 'package:mousa_store/features/auth/repo/signup_repo.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_state.dart';

class MockSignupRepo extends Mock implements SignupRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSignupRepo mockSignupRepo;

  setUp(() {
    mockSignupRepo = MockSignupRepo();
  });

  final sampleResult = SignupResponse(
    success: true,
    message: 'Account created successfully',
  );

  group('SignupCubit Tests', () {
    test('initial state is default SignupState', () async {
      final cubit = SignupCubit(repository: mockSignupRepo);
      expect(cubit.state.status, equals(SignupStatus.initial));
      await cubit.close();
    });

    blocTest<SignupCubit, SignupState>(
      'emits [loading, success] when signup succeeds',
      build: () {
        when(
          () => mockSignupRepo.signup(
            firstName: 'Ahmed',
            lastName: 'Ali',
            email: 'ahmed@example.com',
            phone: '01012345678',
            password: 'password123',
            passwordConfirmation: 'password123',
          ),
        ).thenAnswer((_) async => sampleResult);
        return SignupCubit(repository: mockSignupRepo);
      },
      act: (cubit) => cubit.signup(
        firstName: 'Ahmed',
        lastName: 'Ali',
        email: 'ahmed@example.com',
        phone: '01012345678',
        password: 'password123',
        passwordConfirmation: 'password123',
      ),
      expect: () => [
        const SignupState(status: SignupStatus.loading),
        SignupState(status: SignupStatus.success, response: sampleResult),
      ],
    );

    blocTest<SignupCubit, SignupState>(
      'emits [loading, failure] when signup fails',
      build: () {
        when(
          () => mockSignupRepo.signup(
            firstName: 'Ahmed',
            lastName: 'Ali',
            email: 'ahmed@example.com',
            phone: '01012345678',
            password: 'password123',
            passwordConfirmation: 'password123',
          ),
        ).thenThrow(Exception('Email already taken'));
        return SignupCubit(repository: mockSignupRepo);
      },
      act: (cubit) => cubit.signup(
        firstName: 'Ahmed',
        lastName: 'Ali',
        email: 'ahmed@example.com',
        phone: '01012345678',
        password: 'password123',
        passwordConfirmation: 'password123',
      ),
      expect: () => [
        const SignupState(status: SignupStatus.loading),
        predicate<SignupState>(
          (state) =>
              state.status == SignupStatus.failure &&
              state.errorMessage != null &&
              state.errorMessage!.contains('Email already taken'),
        ),
      ],
    );
  });
}
