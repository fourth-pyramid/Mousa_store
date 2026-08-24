import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/home/models/banner_model.dart';
import 'package:mousa_store/features/home/repositories/home_repository.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
  });

  group('HomeCubit Tests', () {
    test('initial state is default HomeState', () async {
      final cubit = HomeCubit(repository: mockHomeRepository);
      expect(cubit.state.brandsStatus, equals(RequestStatus.initial));
      expect(cubit.state.bannerStatus, equals(RequestStatus.initial));
      await cubit.close();
    });

    blocTest<HomeCubit, HomeState>(
      'fetchBanners emits loading and success with banners',
      build: () {
        when(() => mockHomeRepository.getBanners()).thenAnswer(
          (_) async => [
            const BannerModel(
              id: 1,
              title: 'Summer Sale',
              desc: 'Huge discounts',
              imagePath: 'https://example.com/banner.jpg',
            ),
          ],
        );
        return HomeCubit(repository: mockHomeRepository);
      },
      act: (cubit) => cubit.fetchBanners(),
      expect: () => [
        predicate<HomeState>((s) => s.bannerStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.bannerStatus == RequestStatus.success &&
              s.banners.length == 1 &&
              s.banners.first.title == 'Summer Sale',
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'fetchBrands emits loading and success with brands',
      build: () {
        when(() => mockHomeRepository.getBrands()).thenAnswer(
          (_) async => [
            const Brand(id: 1, name: 'Nike', imagePath: 'https://example.com/nike.png'),
          ],
        );
        return HomeCubit(repository: mockHomeRepository);
      },
      act: (cubit) => cubit.fetchBrands(),
      expect: () => [
        predicate<HomeState>((s) => s.brandsStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.brandsStatus == RequestStatus.success &&
              s.brands.length == 1 &&
              s.brands.first.name == 'Nike',
        ),
      ],
    );
  });
}
