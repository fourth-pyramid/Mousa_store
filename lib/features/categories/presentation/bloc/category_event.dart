import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_event.freezed.dart';

@freezed
sealed class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.fetchStarted() = CategoryFetchStarted;
  const factory CategoryEvent.refreshRequested() = CategoryRefreshRequested;
}
