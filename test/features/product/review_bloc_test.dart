import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/product/domain/usecases/product_use_cases.dart';
import 'package:mousa_store/features/product/presentation/bloc/review_bloc.dart';

class MockAddReviewUseCase extends Mock implements AddReviewUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAddReviewUseCase mockAddReviewUseCase;

  setUp(() {
    mockAddReviewUseCase = MockAddReviewUseCase();
  });

  group('ReviewBloc Tests', () {
    test('initial state is default ReviewState', () async {
      final bloc = ReviewBloc(addReviewUseCase: mockAddReviewUseCase);
      expect(bloc.state.status, equals(ReviewStatus.initial));
      await bloc.close();
    });

    blocTest<ReviewBloc, ReviewState>(
      'addReview emits [loading, success] on successful review submission',
      build: () {
        when(
          () => mockAddReviewUseCase(
            productId: 10,
            rate: 5.0,
            comment: 'Great product!',
          ),
        ).thenAnswer((_) async {});
        return ReviewBloc(addReviewUseCase: mockAddReviewUseCase);
      },
      act: (bloc) => bloc.add(
        const ReviewSubmitted(
          productId: 10,
          rate: 5.0,
          comment: 'Great product!',
        ),
      ),
      expect: () => [
        const ReviewState(status: ReviewStatus.loading),
        const ReviewState(status: ReviewStatus.success),
      ],
    );

    blocTest<ReviewBloc, ReviewState>(
      'addReview emits [loading, failure] when error occurs',
      build: () {
        when(
          () => mockAddReviewUseCase(
            productId: 10,
            rate: 5.0,
            comment: 'Great product!',
          ),
        ).thenThrow(Exception('Server error'));
        return ReviewBloc(addReviewUseCase: mockAddReviewUseCase);
      },
      act: (bloc) => bloc.add(
        const ReviewSubmitted(
          productId: 10,
          rate: 5.0,
          comment: 'Great product!',
        ),
      ),
      expect: () => [
        const ReviewState(status: ReviewStatus.loading),
        predicate<ReviewState>(
          (s) =>
              s.status == ReviewStatus.failure &&
              (s.errorMessage?.contains('Server error') ?? false),
        ),
      ],
    );
  });
}
