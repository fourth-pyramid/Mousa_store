import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
sealed class SearchEvent with _$SearchEvent {
  const factory SearchEvent.queryChanged(String query) = SearchQueryChanged;
  const factory SearchEvent.moreRequested() = SearchMoreRequested;
  const factory SearchEvent.cleared() = SearchCleared;
}
