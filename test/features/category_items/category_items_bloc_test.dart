import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/category_items/data/models/attribute_model.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_items_data.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_items_response.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/category_product.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/domain/usecases/get_category_items_use_case.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_bloc.dart';

class MockGetCategoryItemsUseCase extends Mock
    implements GetCategoryItemsUseCase {}

class MockGetGlobalAttributesUseCase extends Mock
    implements GetGlobalAttributesUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetCategoryItemsUseCase mockGetCategoryItemsUseCase;
  late MockGetGlobalAttributesUseCase mockGetGlobalAttributesUseCase;

  setUp(() {
    mockGetCategoryItemsUseCase = MockGetCategoryItemsUseCase();
    mockGetGlobalAttributesUseCase = MockGetGlobalAttributesUseCase();
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
    data: CategoryItemsData(currentPage: 1, lastPage: 1, data: [sampleProduct]),
  );

  group('CategoryItemsBloc Tests', () {
    test('initial state is default CategoryItemsState', () async {
      final bloc = CategoryItemsBloc(
        getCategoryItemsUseCase: mockGetCategoryItemsUseCase,
        getGlobalAttributesUseCase: mockGetGlobalAttributesUseCase,
        fetchType: ItemFetchType.category,
        categoryId: 1,
      );
      expect(bloc.state.status, equals(CategoryItemsStatus.initial));
      await bloc.close();
    });

    blocTest<CategoryItemsBloc, CategoryItemsState>(
      'fetchItems emits [loading, success] with products',
      build: () {
        when(
          () => mockGetCategoryItemsUseCase(
            fetchType: ItemFetchType.category,
            categoryId: 1,
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
            brandId: any(named: 'brandId'),
            attributeIds: any(named: 'attributeIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            sort: any(named: 'sort'),
          ),
        ).thenAnswer((_) async => sampleResponse);
        when(
          () => mockGetGlobalAttributesUseCase(),
        ).thenAnswer(
          (_) async => AttributeResponse(
            success: true,
            message: 'success',
            data: AttributeResponseData.empty(),
          ),
        );
        return CategoryItemsBloc(
          getCategoryItemsUseCase: mockGetCategoryItemsUseCase,
          getGlobalAttributesUseCase: mockGetGlobalAttributesUseCase,
          fetchType: ItemFetchType.category,
          categoryId: 1,
        );
      },
      act: (bloc) => bloc.add(
        const CategoryItemsFetchRequested(
          fetchType: ItemFetchType.category,
          categoryId: 1,
        ),
      ),
      expect: () => [
        const CategoryItemsState(status: CategoryItemsStatus.loading),
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
