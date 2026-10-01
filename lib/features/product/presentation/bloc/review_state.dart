import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_state.freezed.dart';

enum ReviewStatus { initial, loading, success, failure }

@freezed
sealed class ReviewState with _$ReviewState {
  const factory ReviewState({
    @Default(ReviewStatus.initial) ReviewStatus status,
    String? errorMessage,
  }) = _ReviewState;
}
