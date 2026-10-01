import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<HomeLoadMoreProductsRequested>(_onHomeLoadMoreProductsRequested);
  }

  final FetchHomeDataUseCase _useCase;

  Future<void> _onHomeAllDataRequested(
    HomeAllDataRequested event,
    Emitter<HomeState> emit,
  ) async {
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
    emit(state.copyWith(brandsStatus: RequestStatus.loading));
    try {
      final brands = await _useCase.getBrands();
      emit(state.copyWith(brandsStatus: RequestStatus.success, brands: brands));
    } on Object catch (e) {
      emit(
        state.copyWith(
          brandsStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeBannersRequested(
    HomeBannersRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(bannerStatus: RequestStatus.loading));
    try {
      final banners = await _useCase.getBanners();
      emit(
        state.copyWith(bannerStatus: RequestStatus.success, banners: banners),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          bannerStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeCategoriesRequested(
    HomeCategoriesRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoriesStatus: RequestStatus.loading));
    try {
      final categories = await _useCase.getCategories();
      emit(
        state.copyWith(
          categoriesStatus: RequestStatus.success,
          categories: categories,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          categoriesStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeOfferItemsRequested(
    HomeOfferItemsRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(offersStatus: RequestStatus.loading));
    try {
      final response = await _useCase.getOfferItems();
      emit(
        state.copyWith(
          offersStatus: RequestStatus.success,
          offerProducts: response.data?.data ?? [],
        ),
      );
    } on Object catch (e) {
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
    emit(state.copyWith(recentlyStatus: RequestStatus.loading));
    try {
      final response = await _useCase.getRecentlyItems();
      emit(
        state.copyWith(
          recentlyStatus: RequestStatus.success,
          recentlyProducts: response.data?.data ?? [],
        ),
      );
    } on Object catch (e) {
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
    if (event.page == 1) {
      emit(state.copyWith(allProductsStatus: RequestStatus.loading));
    } else {
      emit(state.copyWith(allProductsPaginationStatus: RequestStatus.loading));
    }

    try {
      final response = await _useCase.getProducts(page: event.page);
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
    add(HomeProductsRequested(page: state.currentPage + 1));
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
