// ignore_for_file: avoid_dynamic_calls // Handles unstructured Map responses from legacy remote API endpoints
import 'package:equatable/equatable.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/favorites/repositories/favorite_repo.dart';
import 'package:mousa_store/features/product/model/product.dart';

part 'favorite_state.dart';

class FavoriteCubit extends SafeCubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(const FavoriteInitial());
  // ponytail: no auto-fetch in constructor — callers invoke getFavorites() explicitly
  final FavoriteRepo favoriteRepo;
  Set<int> favoriteIds = {};
  List<Product> favoriteProducts = [];
  String successMessage = '';

  Future<void> getFavorites() async {
    try {
      final response = await favoriteRepo.getFavorites();
      if (response != null &&
          response['data'] != null &&
          response['data']['data'] != null) {
        final data = response['data']['data'] as List<dynamic>;
        final newFavoriteIds = <int>{};
        final newFavoriteProducts = <Product>[];

        for (final e in data) {
          if (e['id'] != null) {
            newFavoriteIds.add(
              e['id'] is int
                  ? e['id'] as int
                  : int.tryParse(e['id'].toString()) ?? 0,
            );
            try {
              newFavoriteProducts.add(
                Product.fromJson(e as Map<String, dynamic>),
              );
            } on Object {
              // Handle parsing error for individual item
            }
          }
        }
        favoriteIds = newFavoriteIds;
        favoriteProducts = newFavoriteProducts;
      }
      emit(FavoriteLoaded(favoriteIds, favoriteProducts: favoriteProducts));
    } on Object {
      emit(FavoriteLoaded(favoriteIds, favoriteProducts: favoriteProducts));
    }
  }

  Future<void> addFavorite({required int productId, Product? product}) async {
    final isFav = favoriteIds.contains(productId);

    // Create copies for optimistic update
    final newFavoriteIds = Set<int>.from(favoriteIds);
    final newFavoriteProducts = List<Product>.from(favoriteProducts);

    if (isFav) {
      newFavoriteIds.remove(productId);
      newFavoriteProducts.removeWhere((p) => p.id == productId);
      // successMessage = 'تم إزالة المنتج من المفضلة';
    } else {
      newFavoriteIds.add(productId);
      if (product != null) {
        newFavoriteProducts.add(product);
      }
      // successMessage = 'تم إضافة المنتج إلى المفضلة';
    }

    favoriteIds = newFavoriteIds;
    favoriteProducts = newFavoriteProducts;

    emit(FavoriteLoaded(favoriteIds, favoriteProducts: favoriteProducts));

    try {
      if (isFav) {
        await favoriteRepo.removeFavorite(productId: productId);
      } else {
        await favoriteRepo.addFavorite(productId: productId);
      }
      emit(
        FavoriteSuccess(
          successMessage,
          favoriteIds,
          favoriteProducts: favoriteProducts,
        ),
      );
    } on Object catch (e) {
      // Revert changes on error
      final revertedIds = Set<int>.from(favoriteIds);
      final revertedProducts = List<Product>.from(favoriteProducts);

      if (isFav) {
        // Was removed, so add back
        revertedIds.add(productId);
        if (product != null) {
          revertedProducts.add(product);
        }
      } else {
        // Was added, so remove
        revertedIds.remove(productId);
        revertedProducts.removeWhere((p) => p.id == productId);
      }

      favoriteIds = revertedIds;
      favoriteProducts = revertedProducts;

      emit(FavoriteLoaded(favoriteIds, favoriteProducts: favoriteProducts));
      emit(FavoriteError(e.toString()));
    }
  }

  bool isFavorite(int productId) => favoriteIds.contains(productId);

  void reset() {
    favoriteIds = {};
    favoriteProducts = [];
    emit(const FavoriteInitial());
  }
}
