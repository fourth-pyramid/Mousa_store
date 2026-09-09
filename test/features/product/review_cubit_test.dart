import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/product/repo/review_repo.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_cubit.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_state.dart';

class MockReviewRepo extends Mock implements ReviewRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockReviewRepo mockReviewRepo;

  setUp(() {
    mockReviewRepo = MockReviewRepo();
  });

  group('ReviewCubit Tests', () {
    test('initial state is default ReviewState', () async {
      final cubit = ReviewCubit(mockReviewRepo);
      expect(cubit.state.status, equals(ReviewStatus.initial));
      await cubit.close();
    });

    blocTest<ReviewCubit, ReviewState>(
      'addReview emits [loading, success] when review is added',
      build: () {
        when(
          () => mockReviewRepo.addReview(
            productId: 1,
            rate: 5.0,
            comment: 'Great product!',
          ),
        ).thenAnswer((_) async => {});
        return ReviewCubit(mockReviewRepo);
      },
      act: (cubit) =>
          cubit.addReview(productId: 1, rate: 5.0, comment: 'Great product!'),
      expect: () => [
        const ReviewState(status: ReviewStatus.loading),
        const ReviewState(status: ReviewStatus.success),
      ],
    );
  });
}
