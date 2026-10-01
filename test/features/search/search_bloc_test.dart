import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/product/data/models/product.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';
import 'package:mousa_store/features/search/domain/usecases/search_products_use_case.dart';
import 'package:mousa_store/features/search/presentation/bloc/search_bloc.dart';

class MockSearchProductsUseCase extends Mock implements SearchProductsUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSearchProductsUseCase mockSearchProductsUseCase;

  setUp(() {
    mockSearchProductsUseCase = MockSearchProductsUseCase();
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
    data: Data(currentPage: 1, lastPage: 1, data: [sampleProduct]),
  );

  final emptyResponse = ProductListResponse(
    success: true,
    data: Data(currentPage: 1, lastPage: 1, data: []),
  );

  group('SearchBloc Tests', () {
    test('initial state is default SearchState', () async {
      final bloc = SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
      expect(bloc.state.status, equals(SearchStatus.initial));
      await bloc.close();
    });

    blocTest<SearchBloc, SearchState>(
      'SearchQueryChanged emits [loading, success] when results are found',
      build: () {
        when(
          () => mockSearchProductsUseCase(
            'tennis',
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => sampleResponse);
        return SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
      },
      act: (bloc) => bloc.add(const SearchQueryChanged('tennis')),
      expect: () => [
        const SearchState(status: SearchStatus.loading),
        const SearchState(
          status: SearchStatus.success,
          products: [sampleProduct],
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'SearchQueryChanged emits [loading, empty] when no products returned',
      build: () {
        when(
          () => mockSearchProductsUseCase(
            'unknown',
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => emptyResponse);
        return SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
      },
      act: (bloc) => bloc.add(const SearchQueryChanged('unknown')),
      expect: () => [
        const SearchState(status: SearchStatus.loading),
        const SearchState(status: SearchStatus.empty),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'SearchCleared resets state',
      build: () => SearchBloc(searchProductsUseCase: mockSearchProductsUseCase),
      act: (bloc) => bloc.add(const SearchCleared()),
      expect: () => [
        const SearchState(),
      ],
    );
  });
}
