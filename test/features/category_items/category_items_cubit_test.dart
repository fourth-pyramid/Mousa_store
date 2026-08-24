import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_items_data.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_items_response.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/repositories/category_items_repo.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_state.dart';

class MockCategoryItemsRepo extends Mock implements CategoryItemsRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCategoryItemsRepo mockCategoryItemsRepo;

  setUp(() {
    mockCategoryItemsRepo = MockCategoryItemsRepo();
  });

  const sampleProduct = CategoryProduct(
    id: 1,
    name: 'Running T-Shirt',
    desc: 'Breathable sports t-shirt',
    price: '50.0',
    imagePath: 'https://example.com/shirt.png',
    imagesPath: [],
  );

  final sampleResponse = CategoryItemsResponse(
    success: true,
    data: CategoryItemsData(
      currentPage: 1,
      lastPage: 1,
      data: [sampleProduct],
    ),
  );

  group('CategoryItemsCubit Tests', () {
    test('initial state is default CategoryItemsState', () async {
      final cubit = CategoryItemsCubit(
        repository: mockCategoryItemsRepo,
        fetchType: ItemFetchType.category,
        categoryId: 1,
      );
      expect(cubit.state.status, equals(CategoryItemsStatus.initial));
      await cubit.close();
    });

    blocTest<CategoryItemsCubit, CategoryItemsState>(
      'fetchItems emits [loading, success] with products',
      build: () {
        when(
          () => mockCategoryItemsRepo.getItems(
            fetchType: ItemFetchType.category,
            categoryId: 1,
            perPage: any(named: 'perPage'),
            brandId: any(named: 'brandId'),
            attributeIds: any(named: 'attributeIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            sort: any(named: 'sort'),
          ),
        ).thenAnswer((_) async => sampleResponse);
        return CategoryItemsCubit(
          repository: mockCategoryItemsRepo,
          fetchType: ItemFetchType.category,
          categoryId: 1,
        );
      },
      act: (cubit) => cubit.fetchItems(),
      expect: () => [
        const CategoryItemsState(
          status: CategoryItemsStatus.loading,
        ),
        predicate<CategoryItemsState>(
          (s) =>
              s.status == CategoryItemsStatus.success &&
              s.products.length == 1 &&
              s.products.first.name == 'Running T-Shirt',
        ),
      ],
    );
  });
}
