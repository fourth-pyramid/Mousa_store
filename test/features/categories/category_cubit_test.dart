import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/categories/models/category.dart';
import 'package:mousa_store/features/categories/repositories/category_repo.dart';
import 'package:mousa_store/features/categories/viewmodels/category_cubit.dart';
import 'package:mousa_store/features/categories/viewmodels/category_state.dart';

class MockCategoryRepo extends Mock implements CategoryRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCategoryRepo mockCategoryRepo;

  setUp(() {
    mockCategoryRepo = MockCategoryRepo();
  });

  const sampleCategory = Category(
    id: 1,
    name: 'Shoes',
    imagePath: 'https://example.com/shoes.png',
  );

  group('CategoryCubit Tests', () {
    test('initial state is default CategoryState', () async {
      final cubit = CategoryCubit(repository: mockCategoryRepo);
      expect(cubit.state.status, equals(RequestStatus.initial));
      await cubit.close();
    });

    blocTest<CategoryCubit, CategoryState>(
      'getCategories emits [loading, success] when repository succeeds',
      build: () {
        when(
          () => mockCategoryRepo.fetchCategories(),
        ).thenAnswer((_) async => [sampleCategory]);
        return CategoryCubit(repository: mockCategoryRepo);
      },
      act: (cubit) => cubit.getCategories(),
      expect: () => [
        const CategoryState(status: RequestStatus.loading),
        const CategoryState(
          status: RequestStatus.success,
          categories: [sampleCategory],
        ),
      ],
    );

    blocTest<CategoryCubit, CategoryState>(
      'getCategories emits [loading, failure] when repository fails',
      build: () {
        when(
          () => mockCategoryRepo.fetchCategories(),
        ).thenThrow(Exception('Failed to fetch categories'));
        return CategoryCubit(repository: mockCategoryRepo);
      },
      act: (cubit) => cubit.getCategories(),
      expect: () => [
        const CategoryState(status: RequestStatus.loading),
        predicate<CategoryState>(
          (s) =>
              s.status == RequestStatus.failure &&
              s.errorMessage != null &&
              s.errorMessage!.contains('Failed to fetch categories'),
        ),
      ],
    );
  });
}
