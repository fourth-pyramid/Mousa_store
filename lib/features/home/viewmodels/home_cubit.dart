import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/home/repositories/home_repository.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';

class HomeCubit extends SafeCubit<HomeState> {
  HomeCubit({required this.repository}) : super(const HomeState());

  final HomeRepository repository;

  Future<void> fetchAllData() async {
    await Future.wait([
      fetchBanners(),
      fetchBrands(),
      fetchCategories(),
      fetchOfferItems(),
      fetchRecentlyItems(),
      fetchProducts(),
    ]);
  }

  Future<void> fetchBrands() async {
    emit(state.copyWith(brandsStatus: RequestStatus.loading));
    try {
      final brands = await repository.getBrands();
      emit(
        state.copyWith(
          brandsStatus: RequestStatus.success,
          brands: brands,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          brandsStatus: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchBanners() async {
    emit(state.copyWith(bannerStatus: RequestStatus.loading));
    try {
      final banners = await repository.getBanners();
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

  Future<void> fetchCategories() async {
    emit(state.copyWith(categoriesStatus: RequestStatus.loading));
    try {
      final categories = await repository.getCategories();
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

  Future<void> fetchOfferItems() async {
    emit(state.copyWith(offersStatus: RequestStatus.loading));
    try {
      final response = await repository.getOfferItems();
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

  Future<void> fetchRecentlyItems() async {
    emit(state.copyWith(recentlyStatus: RequestStatus.loading));
    try {
      final response = await repository.getRecentlyItems();
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

  Future<void> fetchProducts({int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(allProductsStatus: RequestStatus.loading));
    } else {
      emit(state.copyWith(allProductsPaginationStatus: RequestStatus.loading));
    }

    try {
      final response = await repository.getProducts(page: page);
      final newProducts = response.data?.data ?? [];
      final currentPage = response.data?.currentPage ?? 1;
      final lastPage = response.data?.lastPage ?? 1;

      final updatedProducts = page == 1
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

  Future<void> loadMoreProducts() async {
    if (state.hasReachedMax ||
        state.allProductsStatus == RequestStatus.loading ||
        state.allProductsPaginationStatus == RequestStatus.loading) {
      return;
    }
    await fetchProducts(page: state.currentPage + 1);
  }
}
