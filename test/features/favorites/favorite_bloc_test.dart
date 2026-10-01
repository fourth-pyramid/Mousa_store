import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:mousa_store/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:mousa_store/features/favorites/domain/usecases/toggle_favorite_use_case.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFavoriteRepository mockFavoriteRepository;
  late GetFavoritesUseCase getFavoritesUseCase;
  late ToggleFavoriteUseCase toggleFavoriteUseCase;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    getFavoritesUseCase = GetFavoritesUseCase(mockFavoriteRepository);
    toggleFavoriteUseCase = ToggleFavoriteUseCase(mockFavoriteRepository);
  });

  const sampleProduct = Product(
    id: 10,
    name: 'Football',
    desc: 'Professional match ball',
    price: '25.0',
    imagePath: 'https://example.com/ball.png',
    imagesPath: [],
  );

  group('FavoriteBloc Tests', () {
    test('initial state is default FavoriteState and isFavorite returns false', () async {
      final bloc = FavoriteBloc(
        getFavoritesUseCase: getFavoritesUseCase,
        toggleFavoriteUseCase: toggleFavoriteUseCase,
      );
      expect(bloc.state.status, equals(FavoriteStatus.initial));
      expect(bloc.isFavorite(10), isFalse);
      await bloc.close();
    });

    blocTest<FavoriteBloc, FavoriteState>(
      'FavoritesFetchRequested emits [loading, success] with products',
      build: () {
        when(
          () => mockFavoriteRepository.getFavorites(),
        ).thenAnswer((_) async => [sampleProduct]);
        return FavoriteBloc(
          getFavoritesUseCase: getFavoritesUseCase,
          toggleFavoriteUseCase: toggleFavoriteUseCase,
        );
      },
      act: (bloc) => bloc.add(const FavoritesFetchRequested()),
      expect: () => [
        const FavoriteState(status: FavoriteStatus.loading),
        const FavoriteState(
          status: FavoriteStatus.success,
          favoriteProducts: [sampleProduct],
          favoriteIds: {10},
        ),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'FavoriteToggled adds product optimistically and calls repository',
      build: () {
        when(
          () => mockFavoriteRepository.addFavorite(10),
        ).thenAnswer((_) async {});
        return FavoriteBloc(
          getFavoritesUseCase: getFavoritesUseCase,
          toggleFavoriteUseCase: toggleFavoriteUseCase,
        );
      },
      act: (bloc) => bloc.add(
        const FavoriteToggled(productId: 10, product: sampleProduct),
      ),
      expect: () => [
        const FavoriteState(
          status: FavoriteStatus.success,
          favoriteIds: {10},
          favoriteProducts: [sampleProduct],
          message: 'Added to favorites',
        ),
      ],
      verify: (_) {
        verify(() => mockFavoriteRepository.addFavorite(10)).called(1);
      },
    );
  });
}
