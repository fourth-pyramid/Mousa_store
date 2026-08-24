part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  FavoriteLoaded(this.favoriteIds, {this.favoriteProducts = const []});
  final Set<int> favoriteIds;
  final List<Product> favoriteProducts;

  @override
  List<Object?> get props => [favoriteIds, favoriteProducts];
}

class FavoriteSuccess extends FavoriteState {
  FavoriteSuccess(
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

class FavoriteError extends FavoriteState {
  FavoriteError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
