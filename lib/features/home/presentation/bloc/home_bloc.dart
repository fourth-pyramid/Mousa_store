import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/utils/event_transformers.dart';
import 'package:mousa_store/features/home/domain/usecases/fetch_home_data_use_case.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_event.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required FetchHomeDataUseCase useCase})
    : _useCase = useCase,
      super(const HomeState()) {
    on<HomeAllDataRequested>(_onHomeAllDataRequested);
    on<HomeBannersRequested>(_onHomeBannersRequested);
    on<HomeBrandsRequested>(_onHomeBrandsRequested);
    on<HomeCategoriesRequested>(_onHomeCategoriesRequested);
    on<HomeOfferItemsRequested>(_onHomeOfferItemsRequested);
    on<HomeRecentlyItemsRequested>(_onHomeRecentlyItemsRequested);
    on<HomeProductsRequested>(_onHomeProductsRequested);
    on<HomeLoadMoreProductsRequested>(
      _onHomeLoadMoreProductsRequested,
      transformer: droppable(),
    );
  }

  final FetchHomeDataUseCase _useCase;
  int _generation = 0;
  bool _resetRequested = false;
  String? _contentKey;
  String? get contentKey => _contentKey;

  Future<void> _onHomeAllDataRequested(
    HomeAllDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (_resetRequested) {
      _resetRequested = false;
      emit(const HomeState());
      return;
    }
    _generation++;
    final key = CacheHelper.catalogCacheKey;
    if (_contentKey != key) emit(const HomeState());
    _contentKey = key;
    _useCase.invalidateCache();
    add(const HomeBannersRequested());
    add(const HomeBrandsRequested());
    add(const HomeCategoriesRequested());
    add(const HomeOfferItemsRequested());
    add(const HomeRecentlyItemsRequested());
    add(const HomeProductsRequested());
  }

  Future<void> _onHomeBrandsRequested(
    HomeBrandsRequested event,
    Emitter<HomeState> emit,
  ) async {
    final generation = _generation;
    final key = CacheHelper.catalogCacheKey;
    if (state.brands.isEmpty) {
      emit(state.copyWith(brandsStatus: RequestStatus.loading));
    }
    try {
      final brands = await _useCase.getBrands();
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(state.copyWith(brandsStatus: RequestStatus.success, brands: brands));
    } on Object catch (e) {
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          brandsStatus: state.brands.isEmpty
              ? RequestStatus.failure
              : RequestStatus.success,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeBannersRequested(
    HomeBannersRequested event,
    Emitter<HomeState> emit,
  ) async {
    final generation = _generation;
    final key = CacheHelper.catalogCacheKey;
    if (state.banners.isEmpty) {
      emit(state.copyWith(bannerStatus: RequestStatus.loading));
    }
    try {
      final banners = await _useCase.getBanners();
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(bannerStatus: RequestStatus.success, banners: banners),
      );
    } on Object catch (e) {
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          bannerStatus: state.banners.isEmpty
              ? RequestStatus.failure
              : RequestStatus.success,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeCategoriesRequested(
    HomeCategoriesRequested event,
    Emitter<HomeState> emit,
  ) async {
    final generation = _generation;
    final key = CacheHelper.catalogCacheKey;
    if (state.categories.isEmpty) {
      emit(state.copyWith(categoriesStatus: RequestStatus.loading));
    }
    try {
      final categories = await _useCase.getCategories();
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          categoriesStatus: RequestStatus.success,
          categories: categories,
        ),
      );
    } on Object catch (e) {
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          categoriesStatus: state.categories.isEmpty
              ? RequestStatus.failure
              : RequestStatus.success,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeOfferItemsRequested(
    HomeOfferItemsRequested event,
    Emitter<HomeState> emit,
  ) async {
    final generation = _generation;
    final key = CacheHelper.catalogCacheKey;
    emit(state.copyWith(offersStatus: RequestStatus.loading));
    try {
      final response = await _useCase.getOfferItems();
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          offersStatus: RequestStatus.success,
          offerProducts: response.data?.data ?? [],
        ),
      );
    } on Object catch (e) {
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          offersStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeRecentlyItemsRequested(
    HomeRecentlyItemsRequested event,
    Emitter<HomeState> emit,
  ) async {
    final generation = _generation;
    final key = CacheHelper.catalogCacheKey;
    emit(state.copyWith(recentlyStatus: RequestStatus.loading));
    try {
      final response = await _useCase.getRecentlyItems();
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          recentlyStatus: RequestStatus.success,
          recentlyProducts: response.data?.data ?? [],
        ),
      );
    } on Object catch (e) {
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          recentlyStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeProductsRequested(
    HomeProductsRequested event,
    Emitter<HomeState> emit,
  ) async {
    final generation = _generation;
    final key = CacheHelper.catalogCacheKey;
    if (event.page == 1) {
      emit(state.copyWith(allProductsStatus: RequestStatus.loading));
    } else {
      emit(state.copyWith(allProductsPaginationStatus: RequestStatus.loading));
    }

    try {
      final response = await _useCase.getProducts(page: event.page);
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      final newProducts = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? 1;
      final lastPage = response.data?.lastPage ?? 1;

      final updatedProducts = event.page == 1
          ? newProducts
          : [...state.allProducts, ...newProducts];

      emit(
        state.copyWith(
          allProductsStatus: RequestStatus.success,
          allProductsPaginationStatus: RequestStatus.success,
          allProducts: updatedProducts,
          currentPage: currentPage,
          lastPage: lastPage,
          hasReachedMax: currentPage >= lastPage,
        ),
      );
    } on Object catch (e) {
      if (emit.isDone ||
          generation != _generation ||
          key != CacheHelper.catalogCacheKey) {
        return;
      }
      emit(
        state.copyWith(
          allProductsStatus: RequestStatus.failure,
          allProductsPaginationStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeLoadMoreProductsRequested(
    HomeLoadMoreProductsRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax ||
        state.allProductsStatus == RequestStatus.loading ||
        state.allProductsPaginationStatus == RequestStatus.loading) {
      return;
    }
    await _onHomeProductsRequested(
      HomeProductsRequested(page: state.currentPage + 1),
      emit,
    );
  }

  void resetCatalog() {
    _generation++;
    _contentKey = null;
    _useCase.invalidateCache();
    _resetRequested = true;
    add(const HomeAllDataRequested());
  }

  // Compatibility helpers
  Future<void> fetchAllData() async {
    add(const HomeAllDataRequested());
  }

  Future<void> fetchBanners() async {
    add(const HomeBannersRequested());
  }

  Future<void> fetchBrands() async {
    add(const HomeBrandsRequested());
  }

  Future<void> fetchCategories() async {
    add(const HomeCategoriesRequested());
  }

  Future<void> fetchOfferItems() async {
    add(const HomeOfferItemsRequested());
  }

  Future<void> fetchRecentlyItems() async {
    add(const HomeRecentlyItemsRequested());
  }

  Future<void> fetchProducts({int page = 1}) async {
    add(HomeProductsRequested(page: page));
  }

  Future<void> loadMoreProducts() async {
    add(const HomeLoadMoreProductsRequested());
  }
}
