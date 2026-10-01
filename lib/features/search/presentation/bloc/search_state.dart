import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

part 'search_state.freezed.dart';

enum SearchStatus { initial, loading, success, failure, empty }

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.initial) SearchStatus status,
    @Default([]) List<Product> products,
    String? errorMessage,
    @Default(1) int currentPage,
    @Default(1) int lastPage,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
  }) = _SearchState;
}
