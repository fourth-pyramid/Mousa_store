import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:mousa_store/features/favorites/domain/usecases/toggle_favorite_use_case.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_event.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_state.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

export 'favorite_event.dart';
export 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoriteState()) {
    on<FavoritesFetchRequested>(_onFavoritesFetchRequested);
    on<FavoriteToggled>(_onFavoriteToggled);
    on<FavoriteResetRequested>(_onFavoriteResetRequested);
  }

  void _onFavoriteResetRequested(
    FavoriteResetRequested event,
    Emitter<FavoriteState> emit,
  ) {
    emit(const FavoriteState());
  }

  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  bool isFavorite(int productId) => state.isFavorite(productId);
  Set<int> get favoriteIds => state.favoriteIds;
  List<Product> get favoriteProducts => state.favoriteProducts;
  String get successMessage => state.message ?? '';

  Future<void> getFavorites() async {
    add(const FavoritesFetchRequested());
  }

  Future<void> addFavorite({required int productId, Product? product}) async {
    add(FavoriteToggled(productId: productId, product: product));
  }

  Future<void> _onFavoritesFetchRequested(
    FavoritesFetchRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final products = await getFavoritesUseCase();
      final ids = products.map((p) => p.id).toSet();
      emit(
        state.copyWith(
          status: FavoriteStatus.success,
          favoriteProducts: products,
          favoriteIds: ids,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoriteState> emit,
  ) async {
    final isFav = state.isFavorite(event.productId);
    final previousIds = Set<int>.from(state.favoriteIds);
    final previousProducts = List<Product>.from(state.favoriteProducts);

    final updatedIds = Set<int>.from(state.favoriteIds);
    final updatedProducts = List<Product>.from(state.favoriteProducts);

    if (isFav) {
      updatedIds.remove(event.productId);
      updatedProducts.removeWhere((p) => p.id == event.productId);
      emit(
        state.copyWith(
          status: FavoriteStatus.success,
          favoriteIds: updatedIds,
          favoriteProducts: updatedProducts,
          message: 'Removed from favorites',
        ),
      );

      try {
        await toggleFavoriteUseCase.remove(event.productId);
      } on Object catch (e) {
        emit(
          state.copyWith(
            status: FavoriteStatus.failure,
            favoriteIds: previousIds,
            favoriteProducts: previousProducts,
            errorMessage: e.toString(),
          ),
        );
      }
    } else {
      updatedIds.add(event.productId);
      if (event.product != null) {
        updatedProducts.add(event.product!);
      }
      emit(
        state.copyWith(
          status: FavoriteStatus.success,
          favoriteIds: updatedIds,
          favoriteProducts: updatedProducts,
          message: 'Added to favorites',
        ),
      );

      try {
        await toggleFavoriteUseCase.add(event.productId);
      } on Object catch (e) {
        emit(
          state.copyWith(
            status: FavoriteStatus.failure,
            favoriteIds: previousIds,
            favoriteProducts: previousProducts,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
