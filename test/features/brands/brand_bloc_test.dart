import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/brands/domain/repositories/brand_repository.dart';
import 'package:mousa_store/features/brands/domain/usecases/get_brands_use_case.dart';
import 'package:mousa_store/features/brands/presentation/bloc/brand_bloc.dart';

class MockBrandRepository extends Mock implements BrandRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBrandRepository mockBrandRepository;
  late GetBrandsUseCase getBrandsUseCase;

  setUp(() {
    mockBrandRepository = MockBrandRepository();
    getBrandsUseCase = GetBrandsUseCase(mockBrandRepository);
  });

  const sampleBrand = Brand(
    id: 1,
    name: 'Adidas',
    imagePath: 'https://example.com/adidas.png',
  );

  group('BrandBloc Tests', () {
    test('initial state is default BrandState', () async {
      final bloc = BrandBloc(getBrandsUseCase: getBrandsUseCase);
      expect(bloc.state.status, equals(BrandStatus.initial));
      expect(bloc.state.brands, isEmpty);
      await bloc.close();
    });

    blocTest<BrandBloc, BrandState>(
      'emits [loading, success] when BrandFetchStarted succeeds',
      build: () {
        when(
          () => mockBrandRepository.getBrands(),
        ).thenAnswer((_) async => [sampleBrand]);
        return BrandBloc(getBrandsUseCase: getBrandsUseCase);
      },
      act: (bloc) => bloc.add(const BrandFetchStarted()),
      expect: () => [
        const BrandState(status: BrandStatus.loading),
        const BrandState(status: BrandStatus.success, brands: [sampleBrand]),
      ],
    );

    blocTest<BrandBloc, BrandState>(
      'emits [loading, failure] when BrandFetchStarted fails',
      build: () {
        when(
          () => mockBrandRepository.getBrands(),
        ).thenThrow(Exception('Failed to fetch brands'));
        return BrandBloc(getBrandsUseCase: getBrandsUseCase);
      },
      act: (bloc) => bloc.add(const BrandFetchStarted()),
      expect: () => [
        const BrandState(status: BrandStatus.loading),
        predicate<BrandState>(
          (s) =>
              s.status == BrandStatus.failure &&
              s.errorMessage != null &&
              s.errorMessage!.contains('Failed to fetch brands'),
        ),
      ],
    );

    blocTest<BrandBloc, BrandState>(
      'emits [loading, success] when BrandRefreshRequested succeeds',
      build: () {
        when(
          () => mockBrandRepository.getBrands(),
        ).thenAnswer((_) async => [sampleBrand]);
        return BrandBloc(getBrandsUseCase: getBrandsUseCase);
      },
      act: (bloc) => bloc.add(const BrandRefreshRequested()),
      expect: () => [
        const BrandState(status: BrandStatus.loading),
        const BrandState(status: BrandStatus.success, brands: [sampleBrand]),
      ],
    );
  });
}
