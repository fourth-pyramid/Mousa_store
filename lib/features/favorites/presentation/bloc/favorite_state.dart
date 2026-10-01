import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

part 'favorite_state.freezed.dart';

enum FavoriteStatus { initial, loading, success, failure }

@freezed
abstract class FavoriteState with _$FavoriteState {
  const FavoriteState._();

  const factory FavoriteState({
    @Default(FavoriteStatus.initial) FavoriteStatus status,
    @Default({}) Set<int> favoriteIds,
    @Default([]) List<Product> favoriteProducts,
    String? message,
    String? errorMessage,
  }) = _FavoriteState;

  bool isFavorite(int id) => favoriteIds.contains(id);
}
