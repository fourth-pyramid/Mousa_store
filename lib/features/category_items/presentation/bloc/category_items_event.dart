import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/domain/entities/product_filter.dart';

part 'category_items_event.freezed.dart';

@freezed
sealed class CategoryItemsEvent with _$CategoryItemsEvent {
  const factory CategoryItemsEvent.fetchRequested({
    required ItemFetchType fetchType,
    int? categoryId,
    int? brandId,
  }) = CategoryItemsFetchRequested;

  const factory CategoryItemsEvent.loadMoreRequested() =
      CategoryItemsLoadMoreRequested;

  const factory CategoryItemsEvent.filterApplied(ProductFilter filter) =
      CategoryItemsFilterApplied;

  const factory CategoryItemsEvent.sortApplied(ProductSort sort) =
      CategoryItemsSortApplied;

  const factory CategoryItemsEvent.filterReset() = CategoryItemsFilterReset;
}
