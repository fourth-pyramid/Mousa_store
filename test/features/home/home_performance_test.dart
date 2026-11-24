import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/features/home/data/models/banner_model.dart';
import 'package:mousa_store/features/home/domain/usecases/fetch_home_data_use_case.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_event.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_state.dart';
import 'package:mousa_store/features/product/data/models/product_list_response.dart';
import 'package:mousa_store/features/product/data/models/product.dart';

class _UseCase extends Mock implements FetchHomeDataUseCase {}

void main() {
  const banner = BannerModel(id: 1, title: 'banner', desc: '', imagePath: '');
  const product = Product(
    id: 1,
    name: '',
    desc: '',
    price: '10',
    imagePath: '',
    imagesPath: [],
  );
  late _UseCase useCase;
  late HomeBloc bloc;
  setUp(() {
    useCase = _UseCase();
    bloc = HomeBloc(useCase: useCase);
  });
  tearDown(() async {
    await bloc.close();
  });
  test('refresh keeps banner visible and retains it when offline', () async {
    when(() => useCase.getBanners()).thenAnswer((_) async => [banner]);
    bloc.add(const HomeBannersRequested());
    await bloc.stream.firstWhere(
      (s) => s.bannerStatus == RequestStatus.success,
    );
    final pending = Completer<List<BannerModel>>();
    when(() => useCase.getBanners()).thenAnswer((_) => pending.future);
    final observed = <HomeState>[];
    final subscription = bloc.stream.listen(observed.add);
    bloc.add(const HomeBannersRequested());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.banners, [banner]);
    expect(bloc.state.bannerStatus, RequestStatus.success);
    pending.completeError(StateError('offline'));
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.banners, [banner]);
    expect(bloc.state.bannerStatus, RequestStatus.success);
    expect(
      observed.any((s) => s.bannerStatus == RequestStatus.loading),
      isFalse,
    );
    await subscription.cancel();
  });
  test('load-more awaits the actual request and drops overlap', () async {
    when(() => useCase.getProducts(page: 1)).thenAnswer(
      (_) async => ProductListResponse(
        success: true,
        data: Data(data: [product], currentPage: 1, lastPage: 3),
      ),
    );
    bloc.add(const HomeProductsRequested());
    await bloc.stream.firstWhere(
      (s) => s.allProductsStatus == RequestStatus.success,
    );
    final pending = Completer<ProductListResponse>();
    when(() => useCase.getProducts(page: 2)).thenAnswer((_) => pending.future);
    bloc.add(const HomeLoadMoreProductsRequested());
    bloc.add(const HomeLoadMoreProductsRequested());
    await Future<void>.delayed(Duration.zero);
    verify(() => useCase.getProducts(page: 2)).called(1);
    pending.complete(
      ProductListResponse(
        success: true,
        data: Data(data: [product], currentPage: 2, lastPage: 3),
      ),
    );
    await bloc.stream.firstWhere((s) => s.currentPage == 2);
    expect(bloc.state.allProducts.length, 2);
  });
  test(
    'reset invalidates in-flight responses without fetching new data',
    () async {
      final pending = Completer<List<BannerModel>>();
      when(() => useCase.getBanners()).thenAnswer((_) => pending.future);
      bloc.add(const HomeBannersRequested());
      await bloc.stream.firstWhere(
        (s) => s.bannerStatus == RequestStatus.loading,
      );
      bloc.resetCatalog();
      await Future<void>.delayed(Duration.zero);
      pending.complete([banner]);
      await Future<void>.delayed(Duration.zero);
      expect(bloc.state, const HomeState());
      verify(() => useCase.invalidateCache()).called(1);
      verify(() => useCase.getBanners()).called(1);
      verifyNever(() => useCase.getBrands());
    },
  );
}
