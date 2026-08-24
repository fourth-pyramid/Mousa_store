import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/product/repo/review_repo.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_state.dart';

class ReviewCubit extends SafeCubit<ReviewState> {
  ReviewCubit(this._reviewRepo) : super(const ReviewState());

  final ReviewRepo _reviewRepo;

  Future<void> addReview({
    required int productId,
    required double rate,
    required String comment,
  }) async {
    emit(state.copyWith(status: ReviewStatus.loading));
    try {
      await _reviewRepo.addReview(
        productId: productId,
        rate: rate,
        comment: comment,
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
