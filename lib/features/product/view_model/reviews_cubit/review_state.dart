import 'package:equatable/equatable.dart';

enum ReviewStatus { initial, loading, success, failure }

class ReviewState extends Equatable {
  const ReviewState({this.status = ReviewStatus.initial, this.errorMessage});

  final ReviewStatus status;
  final String? errorMessage;

  ReviewState copyWith({ReviewStatus? status, String? errorMessage}) =>
      ReviewState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status, errorMessage];
}
