import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:mousa_store/features/setting_profile/service/profile_service.dart';
import 'package:mousa_store/features/setting_profile/view_model/profile_cubit/profile_cubit.dart';

class MockProfileService extends Mock implements ProfileService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProfileService mockProfileService;

  setUp(() {
    mockProfileService = MockProfileService();
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
      final cubit = ProfileCubit(mockProfileService);
      expect(cubit.state, isA<ProfileInitial>());
      await cubit.close();
    });

    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when getProfile succeeds',
      build: () {
        when(() => mockProfileService.getProfile()).thenAnswer((_) async => sampleUser);
        return ProfileCubit(mockProfileService);
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileLoaded>(),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileLoading, ProfileError] when getProfile returns null',
      build: () {
        when(() => mockProfileService.getProfile()).thenAnswer((_) async => null);
        return ProfileCubit(mockProfileService);
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileError>(),
      ],
    );
  });
}
