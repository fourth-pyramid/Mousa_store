import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/product/domain/usecases/product_use_cases.dart';
import 'package:mousa_store/features/product/presentation/bloc/review_event.dart';
import 'package:mousa_store/features/product/presentation/bloc/review_state.dart';

export 'review_event.dart';
export 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({required this.addReviewUseCase}) : super(const ReviewState()) {
    on<ReviewSubmitted>(_onReviewSubmitted);
  }

  final AddReviewUseCase addReviewUseCase;

  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  }) async {
    add(ReviewSubmitted(productId: productId, rate: rate, comment: comment));
  }

  Future<void> _onReviewSubmitted(
    ReviewSubmitted event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: ReviewStatus.loading));
    try {
      await addReviewUseCase(
        productId: event.productId,
        rate: event.rate,
        comment: event.comment,
      );
      emit(state.copyWith(status: ReviewStatus.success));
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: ReviewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
