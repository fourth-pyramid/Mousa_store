import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/product/data/models/product.dart';
import 'package:mousa_store/features/search/domain/usecases/search_products_use_case.dart';
import 'package:mousa_store/features/search/presentation/bloc/search_event.dart';
import 'package:mousa_store/features/search/presentation/bloc/search_state.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.searchProductsUseCase})
      : super(const SearchState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchMoreRequested>(_onSearchMoreRequested);
    on<SearchCleared>(_onSearchCleared);
  }

  final SearchProductsUseCase searchProductsUseCase;
  final int perPage = 10;
  String lastQuery = '';

  CancelToken? _cancelToken;

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      lastQuery = '';
      _cancelToken?.cancel('Search cleared');
      emit(const SearchState());
      return;
    }

    _cancelToken?.cancel('New search started');
    _cancelToken = CancelToken();

    lastQuery = query;
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        currentPage: 1,
        hasReachedMax: false,
      ),
    );

    try {
      final response = await searchProductsUseCase(
        query,
        perPage: perPage,
        cancelToken: _cancelToken,
      );

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
      if (e.toString().contains('Request cancelled')) return;
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSearchMoreRequested(
    SearchMoreRequested event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore || lastQuery.isEmpty) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;

      final response = await searchProductsUseCase(
        lastQuery,
        page: nextPage,
        perPage: perPage,
        cancelToken: _cancelToken,
      );

      final newProducts = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? state.currentPage;
      final lastPage = response.data?.lastPage ?? state.lastPage;

      final updatedProducts = List<Product>.from(state.products)
        ..addAll(newProducts);

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

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    lastQuery = '';
    _cancelToken?.cancel('Search cleared');
    emit(const SearchState());
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel('SearchBloc closed');
    return super.close();
  }
}
