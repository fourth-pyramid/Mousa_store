import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/setting_profile/repo/profile_repo.dart';
import 'package:mousa_store/features/setting_profile/view_model/profile_cubit/profile_cubit.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProfileRepo mockProfileRepo;
  late MockAuthService mockAuthService;

  setUp(() {
    mockProfileRepo = MockProfileRepo();
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

  group('ProfileCubit Tests', () {
    test('initial state is ProfileInitial', () async {
      final cubit = ProfileCubit(
        profileRepo: mockProfileRepo,
        authService: mockAuthService,
      );
      expect(cubit.state, isA<ProfileInitial>());
      await cubit.close();
    });

    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when getProfile succeeds',
      build: () {
        when(
          () => mockProfileRepo.getProfile(),
        ).thenAnswer((_) async => sampleUser);
        return ProfileCubit(
          profileRepo: mockProfileRepo,
          authService: mockAuthService,
        );
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [isA<ProfileLoading>(), isA<ProfileLoaded>()],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileLoading, ProfileError] when getProfile returns null',
      build: () {
        when(() => mockProfileRepo.getProfile()).thenAnswer((_) async => null);
        return ProfileCubit(
          profileRepo: mockProfileRepo,
          authService: mockAuthService,
        );
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [isA<ProfileLoading>(), isA<ProfileError>()],
    );
  });
}
