import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/product/model/product.dart';

enum SearchStatus { initial, loading, success, failure, empty }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.lastPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final SearchStatus status;
  final List<Product> products;
  final String? errorMessage;
  final int currentPage;
  final int lastPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  SearchState copyWith({
    SearchStatus? status,
    List<Product>? products,
    String? errorMessage,
    int? currentPage,
    int? lastPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) => SearchState(
    status: status ?? this.status,
    products: products ?? this.products,
    errorMessage: errorMessage ?? this.errorMessage,
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );

  @override
  List<Object?> get props => [
    status,
    products,
    errorMessage,
    currentPage,
    lastPage,
    hasReachedMax,
    isLoadingMore,
  ];
}
