import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/features/auth/data/models/user.dart';
import 'package:mousa_store/features/setting_profile/domain/usecases/profile_use_cases.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/profile_bloc.dart';

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late MockAuthService mockAuthService;

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    mockUpdateProfileUseCase = MockUpdateProfileUseCase();
    mockAuthService = MockAuthService();
  });

  final sampleUser = User(
    id: 1,
    firstName: 'Mousa',
    lastName: 'Store',
    email: 'mousa@example.com',
    phone: '01000000000',
    userType: 'customer',
    isVerified: true,
  );

  group('ProfileBloc Tests', () {
    test('initial state is ProfileInitial', () {
      final bloc = ProfileBloc(
        getProfileUseCase: mockGetProfileUseCase,
        updateProfileUseCase: mockUpdateProfileUseCase,
        authService: mockAuthService,
      );
      expect(bloc.state, isA<ProfileInitial>());
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when fetchRequested succeeds',
      build: () {
        when(
          () => mockGetProfileUseCase(),
        ).thenAnswer((_) async => sampleUser);
        return ProfileBloc(
          getProfileUseCase: mockGetProfileUseCase,
          updateProfileUseCase: mockUpdateProfileUseCase,
          authService: mockAuthService,
        );
      },
      act: (bloc) => bloc.add(const ProfileEvent.fetchRequested()),
      expect: () => [isA<ProfileLoading>(), isA<ProfileLoaded>()],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileError] when fetchRequested returns null',
      build: () {
        when(() => mockGetProfileUseCase()).thenAnswer((_) async => null);
        return ProfileBloc(
          getProfileUseCase: mockGetProfileUseCase,
          updateProfileUseCase: mockUpdateProfileUseCase,
          authService: mockAuthService,
        );
      },
      act: (bloc) => bloc.add(const ProfileEvent.fetchRequested()),
      expect: () => [isA<ProfileLoading>(), isA<ProfileError>()],
    );
  });
}
