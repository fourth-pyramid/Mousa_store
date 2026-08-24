import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/product/model/product.dart';
import 'package:mousa_store/features/search/repo/search_repo.dart';
import 'package:mousa_store/features/search/view_model/search_state.dart';

class SearchCubit extends SafeCubit<SearchState> {
  SearchCubit(this._searchRepo) : super(const SearchState());

  final SearchRepo _searchRepo;
  final int perPage = 10;
  String lastQuery = '';

  // ponytail: Timer + CancelToken — no rxdart or extra wrapper needed
  Timer? _debounce;
  CancelToken? _cancelToken;

  static const _debounceDuration = Duration(milliseconds: 400);

  /// Call this directly from the TextField's onChanged.
  void onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.isEmpty) {
      clearSearch();
      return;
    }
    _debounce = Timer(_debounceDuration, () => search(query));
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    // Cancel any previous in-flight search before starting a new one
    _cancelToken?.cancel('New search started');
    _cancelToken = CancelToken();

    lastQuery = query;
    emit(state.copyWith(status: SearchStatus.loading, currentPage: 1, hasReachedMax: false));

    try {
      final response = await _searchRepo.searchProducts(query, perPage: perPage, cancelToken: _cancelToken);

      final products = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? 1;
      final lastPage = response.data?.lastPage ?? 1;

      if (products.isEmpty) {
        emit(state.copyWith(status: SearchStatus.empty));
      } else {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            products: products,
            currentPage: currentPage,
            lastPage: lastPage,
            hasReachedMax: currentPage >= lastPage,
          ),
        );
      }
    } on Object catch (e) {
      // Ignore cancellation — it's intentional
      if (e.toString().contains('Request cancelled')) return;
      emit(state.copyWith(status: SearchStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> loadMoreProducts() async {
    if (state.hasReachedMax || state.isLoadingMore || lastQuery.isEmpty) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;

      final response = await _searchRepo.searchProducts(
        lastQuery,
        page: nextPage,
        perPage: perPage,
        cancelToken: _cancelToken,
      );

      final newProducts = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? state.currentPage;
      final lastPage = response.data?.lastPage ?? state.lastPage;

      final updatedProducts = List<Product>.from(state.products)..addAll(newProducts);

      emit(
        state.copyWith(
          products: updatedProducts,
          currentPage: currentPage,
          lastPage: lastPage,
          hasReachedMax: currentPage >= lastPage,
          isLoadingMore: false,
        ),
      );
    } on Object catch (e) {
      if (e.toString().contains('Request cancelled')) return;
      emit(state.copyWith(isLoadingMore: false, errorMessage: e.toString()));
    }
  }

  void clearSearch() {
    lastQuery = '';
    emit(const SearchState());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _cancelToken?.cancel('SearchCubit closed');
    return super.close();
  }
}
