part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

final class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

final class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();
}

final class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded(this.favoriteIds, {this.favoriteProducts = const []});
  final Set<int> favoriteIds;
  final List<Product> favoriteProducts;

  @override
  List<Object?> get props => [favoriteIds, favoriteProducts];
}

final class FavoriteSuccess extends FavoriteState {
  const FavoriteSuccess(
    this.message,
    this.favoriteIds, {
    this.favoriteProducts = const [],
  });
  final String message;
  final Set<int> favoriteIds;
  final List<Product> favoriteProducts;

  @override
  List<Object?> get props => [message, favoriteIds, favoriteProducts];
}

final class FavoriteError extends FavoriteState {
  const FavoriteError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
