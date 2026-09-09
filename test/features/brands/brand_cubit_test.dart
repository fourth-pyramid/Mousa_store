import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/brands/models/brand.dart';
import 'package:mousa_store/features/brands/repositories/brand_repo.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_cubit.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_state.dart';

class MockBrandRepo extends Mock implements BrandRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBrandRepo mockBrandRepo;

  setUp(() {
    mockBrandRepo = MockBrandRepo();
  });

  const sampleBrand = Brand(
    id: 1,
    name: 'Adidas',
    imagePath: 'https://example.com/adidas.png',
  );

  group('BrandCubit Tests', () {
    test('initial state is default BrandState', () async {
      final cubit = BrandCubit(repository: mockBrandRepo);
      expect(cubit.state.status, equals(RequestStatus.initial));
      await cubit.close();
    });

    blocTest<BrandCubit, BrandState>(
      'getBrands emits [loading, success] when repository succeeds',
      build: () {
        when(
          () => mockBrandRepo.fetchBrands(),
        ).thenAnswer((_) async => [sampleBrand]);
        return BrandCubit(repository: mockBrandRepo);
      },
      act: (cubit) => cubit.getBrands(),
      expect: () => [
        const BrandState(status: RequestStatus.loading),
        const BrandState(status: RequestStatus.success, brands: [sampleBrand]),
      ],
    );

    blocTest<BrandCubit, BrandState>(
      'getBrands emits [loading, failure] when repository fails',
      build: () {
        when(
          () => mockBrandRepo.fetchBrands(),
        ).thenThrow(Exception('Failed to fetch brands'));
        return BrandCubit(repository: mockBrandRepo);
      },
      act: (cubit) => cubit.getBrands(),
      expect: () => [
        const BrandState(status: RequestStatus.loading),
        predicate<BrandState>(
          (s) =>
              s.status == RequestStatus.failure &&
              s.errorMessage != null &&
              s.errorMessage!.contains('Failed to fetch brands'),
        ),
      ],
    );
  });
}
