import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/favorites/repositories/favorite_repo.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';
import 'package:mousa_store/features/product/model/product.dart';

class MockFavoriteRepo extends Mock implements FavoriteRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFavoriteRepo mockFavoriteRepo;

  setUp(() {
    mockFavoriteRepo = MockFavoriteRepo();
  });

  const sampleProduct = Product(
    id: 10,
    name: 'Football',
    desc: 'Professional match ball',
    price: '25.0',
    imagePath: 'https://example.com/ball.png',
    imagesPath: [],
  );

  group('FavoriteCubit Tests', () {
    test('initial state is FavoriteInitial and isFavorite returns false', () async {
      final cubit = FavoriteCubit(mockFavoriteRepo);
      expect(cubit.state, isA<FavoriteInitial>());
      expect(cubit.isFavorite(10), isFalse);
      await cubit.close();
    });

    test('addFavorite toggles favorite state and calls repository', () async {
      when(() => mockFavoriteRepo.addFavorite(productId: 10)).thenAnswer(
        (_) async => {'success': true},
      );

      final cubit = FavoriteCubit(mockFavoriteRepo);
      await cubit.addFavorite(productId: 10, product: sampleProduct);

      expect(cubit.isFavorite(10), isTrue);
      expect(cubit.favoriteProducts.length, equals(1));
      expect(cubit.favoriteProducts.first.name, equals('Football'));

      await cubit.close();
    });
  });
}
