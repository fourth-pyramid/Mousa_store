import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/categories/domain/repositories/category_repository.dart';
import 'package:mousa_store/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:mousa_store/features/categories/presentation/bloc/category_bloc.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCategoryRepository mockCategoryRepository;
  late GetCategoriesUseCase getCategoriesUseCase;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    getCategoriesUseCase = GetCategoriesUseCase(mockCategoryRepository);
  });

  const sampleCategory = Category(
    id: 1,
    name: 'Shoes',
    imagePath: 'https://example.com/shoes.png',
  );

  group('CategoryBloc Tests', () {
    test('initial state is default CategoryState', () async {
      final bloc = CategoryBloc(getCategoriesUseCase: getCategoriesUseCase);
      expect(bloc.state.status, equals(CategoryStatus.initial));
      expect(bloc.state.categories, isEmpty);
      await bloc.close();
    });

    blocTest<CategoryBloc, CategoryState>(
      'emits [loading, success] when CategoryFetchStarted succeeds',
      build: () {
        when(
          () => mockCategoryRepository.getCategories(),
        ).thenAnswer((_) async => [sampleCategory]);
        return CategoryBloc(getCategoriesUseCase: getCategoriesUseCase);
      },
      act: (bloc) => bloc.add(const CategoryFetchStarted()),
      expect: () => [
        const CategoryState(status: CategoryStatus.loading),
        const CategoryState(
          status: CategoryStatus.success,
          categories: [sampleCategory],
        ),
      ],
    );

    blocTest<CategoryBloc, CategoryState>(
      'emits [loading, failure] when CategoryFetchStarted fails',
      build: () {
        when(
          () => mockCategoryRepository.getCategories(),
        ).thenThrow(Exception('Failed to fetch categories'));
        return CategoryBloc(getCategoriesUseCase: getCategoriesUseCase);
      },
      act: (bloc) => bloc.add(const CategoryFetchStarted()),
      expect: () => [
        const CategoryState(status: CategoryStatus.loading),
        predicate<CategoryState>(
          (s) =>
              s.status == CategoryStatus.failure &&
              s.errorMessage != null &&
              s.errorMessage!.contains('Failed to fetch categories'),
        ),
      ],
    );

    blocTest<CategoryBloc, CategoryState>(
      'emits [loading, success] when CategoryRefreshRequested succeeds',
      build: () {
        when(
          () => mockCategoryRepository.getCategories(),
        ).thenAnswer((_) async => [sampleCategory]);
        return CategoryBloc(getCategoriesUseCase: getCategoriesUseCase);
      },
      act: (bloc) => bloc.add(const CategoryRefreshRequested()),
      expect: () => [
        const CategoryState(status: CategoryStatus.loading),
        const CategoryState(
          status: CategoryStatus.success,
          categories: [sampleCategory],
        ),
      ],
    );
  });
}
