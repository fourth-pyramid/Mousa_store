import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/features/product/model/product_list_response.dart';
import 'package:mousa_store/features/search/repo/search_repo.dart';
import 'package:mousa_store/features/search/view_model/search_cubit.dart';
import 'package:mousa_store/features/search/view_model/search_state.dart';

class MockSearchRepo extends Mock implements SearchRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSearchRepo mockSearchRepo;

  setUp(() {
    mockSearchRepo = MockSearchRepo();
  });

  const sampleProduct = Product(
    id: 1,
    name: 'Tennis Racket',
    desc: 'Lightweight graphite racket',
    price: '150.0',
    imagePath: 'https://example.com/racket.png',
    imagesPath: [],
  );

  final sampleResponse = ProductListResponse(
    success: true,
    data: Data(
      currentPage: 1,
      lastPage: 1,
      data: [sampleProduct],
    ),
  );

  group('SearchCubit Tests', () {
    test('initial state is default SearchState', () async {
      final cubit = SearchCubit(mockSearchRepo);
      expect(cubit.state.status, equals(SearchStatus.initial));
      await cubit.close();
    });

    blocTest<SearchCubit, SearchState>(
      'search emits [loading, success] when results are found',
      build: () {
        when(
          () => mockSearchRepo.searchProducts(
            'tennis',
            perPage: any(named: 'perPage'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => sampleResponse);
        return SearchCubit(mockSearchRepo);
      },
      act: (cubit) => cubit.search('tennis'),
      expect: () => [
        const SearchState(status: SearchStatus.loading),
        const SearchState(
          status: SearchStatus.success,
          products: [sampleProduct],
          hasReachedMax: true,
        ),
      ],
    );
  });
}
