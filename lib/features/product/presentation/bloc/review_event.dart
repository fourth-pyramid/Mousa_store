import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_event.freezed.dart';

@freezed
sealed class ReviewEvent with _$ReviewEvent {
  const factory ReviewEvent.submitted({
    required int productId,
    required double rate,
    required String comment,
  }) = ReviewSubmitted;
}
