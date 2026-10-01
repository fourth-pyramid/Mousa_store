import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.allDataRequested() = HomeAllDataRequested;
  const factory HomeEvent.bannersRequested() = HomeBannersRequested;
  const factory HomeEvent.brandsRequested() = HomeBrandsRequested;
  const factory HomeEvent.categoriesRequested() = HomeCategoriesRequested;
  const factory HomeEvent.offerItemsRequested() = HomeOfferItemsRequested;
  const factory HomeEvent.recentlyItemsRequested() = HomeRecentlyItemsRequested;
  const factory HomeEvent.productsRequested({@Default(1) int page}) =
      HomeProductsRequested;
  const factory HomeEvent.loadMoreProductsRequested() =
      HomeLoadMoreProductsRequested;
}
