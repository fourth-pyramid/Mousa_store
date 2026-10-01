import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';
import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/home/domain/usecases/fetch_home_data_use_case.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_event.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_state.dart';
import 'package:mousa_store/features/product/data/models/product.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';

class MockFetchHomeDataUseCase extends Mock implements FetchHomeDataUseCase {}

const _product1 = Product(
  id: 10,
  name: 'Discounted Shoes',
  desc: '',
  price: '120',
  imagePath: '',
  imagesPath: [],
);

const _product2 = Product(
  id: 20,
  name: 'Recent Jacket',
  desc: '',
  price: '200',
  imagePath: '',
  imagesPath: [],
);

const _product3 = Product(
  id: 30,
  name: 'Product 1',
  desc: '',
  price: '99',
  imagePath: '',
  imagesPath: [],
);

ProductListResponse _makeResponse({
  required List<Product> products,
  int currentPage = 1,
  int lastPage = 1,
}) =>
    ProductListResponse(
      success: true,
      message: 'Success',
      data: Data(data: products, currentPage: currentPage, lastPage: lastPage),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFetchHomeDataUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockFetchHomeDataUseCase();
  });

  group('HomeBloc Tests', () {
    test('initial state is default HomeState', () async {
      final bloc = HomeBloc(useCase: mockUseCase);
      expect(bloc.state.brandsStatus, equals(RequestStatus.initial));
      expect(bloc.state.bannerStatus, equals(RequestStatus.initial));
      expect(bloc.state.categoriesStatus, equals(RequestStatus.initial));
      expect(bloc.state.offersStatus, equals(RequestStatus.initial));
      expect(bloc.state.recentlyStatus, equals(RequestStatus.initial));
      expect(bloc.state.allProductsStatus, equals(RequestStatus.initial));
      await bloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'HomeBannersRequested emits loading then success with banners',
      build: () {
        when(() => mockUseCase.getBanners()).thenAnswer(
          (_) async => [
            const BannerModel(
              id: 1,
              title: 'Summer Sale',
              desc: 'Huge discounts',
              imagePath: 'https://example.com/banner.jpg',
            ),
          ],
        );
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeBannersRequested()),
      expect: () => [
        predicate<HomeState>((s) => s.bannerStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.bannerStatus == RequestStatus.success &&
              s.banners.length == 1 &&
              s.banners.first.title == 'Summer Sale',
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeBannersRequested emits failure on error',
      build: () {
        when(() => mockUseCase.getBanners()).thenThrow(
          Exception('Failed to load banners'),
        );
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeBannersRequested()),
      expect: () => [
        predicate<HomeState>((s) => s.bannerStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.bannerStatus == RequestStatus.failure &&
              (s.errorMessage ?? '').contains('Failed to load banners'),
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeBrandsRequested emits loading then success with brands',
      build: () {
        when(() => mockUseCase.getBrands()).thenAnswer(
          (_) async => [
            const Brand(
              id: 1,
              name: 'Nike',
              imagePath: 'https://example.com/nike.png',
            ),
          ],
        );
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeBrandsRequested()),
      expect: () => [
        predicate<HomeState>((s) => s.brandsStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.brandsStatus == RequestStatus.success &&
              s.brands.length == 1 &&
              s.brands.first.name == 'Nike',
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeCategoriesRequested emits loading then success',
      build: () {
        when(() => mockUseCase.getCategories()).thenAnswer(
          (_) async => [
            const Category(
              id: 1,
              name: 'Electronics',
              imagePath: 'https://example.com/electronics.png',
            ),
          ],
        );
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeCategoriesRequested()),
      expect: () => [
        predicate<HomeState>((s) => s.categoriesStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.categoriesStatus == RequestStatus.success &&
              s.categories.length == 1 &&
              s.categories.first.name == 'Electronics',
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeOfferItemsRequested emits loading then success with offers',
      build: () {
        when(
          () => mockUseCase.getOfferItems(page: any(named: 'page')),
        ).thenAnswer((_) async => _makeResponse(products: [_product1]));
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeOfferItemsRequested()),
      expect: () => [
        predicate<HomeState>((s) => s.offersStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.offersStatus == RequestStatus.success &&
              s.offerProducts.length == 1 &&
              s.offerProducts.first.name == 'Discounted Shoes',
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeRecentlyItemsRequested emits loading then success',
      build: () {
        when(
          () => mockUseCase.getRecentlyItems(page: any(named: 'page')),
        ).thenAnswer((_) async => _makeResponse(products: [_product2]));
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeRecentlyItemsRequested()),
      expect: () => [
        predicate<HomeState>((s) => s.recentlyStatus == RequestStatus.loading),
        predicate<HomeState>(
          (s) =>
              s.recentlyStatus == RequestStatus.success &&
              s.recentlyProducts.length == 1 &&
              s.recentlyProducts.first.name == 'Recent Jacket',
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeProductsRequested page=1 emits loading then success',
      build: () {
        when(
          () => mockUseCase.getProducts(),
        ).thenAnswer(
          (_) async => _makeResponse(products: [_product3], lastPage: 2),
        );
        return HomeBloc(useCase: mockUseCase);
      },
      act: (bloc) => bloc.add(const HomeProductsRequested()),
      expect: () => [
        predicate<HomeState>(
          (s) => s.allProductsStatus == RequestStatus.loading,
        ),
        predicate<HomeState>(
          (s) =>
              s.allProductsStatus == RequestStatus.success &&
              s.allProducts.length == 1 &&
              s.currentPage == 1 &&
              s.lastPage == 2 &&
              !s.hasReachedMax,
        ),
      ],
    );
  });
}
