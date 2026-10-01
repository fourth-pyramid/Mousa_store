import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/product/domain/usecases/product_use_cases.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_event.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_state.dart';

export 'product_event.dart';
export 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.getProductUseCase})
      : super(const ProductState()) {
    on<ProductFetchRequested>(_onFetchRequested);
    on<ProductRefreshRequested>(_onRefreshRequested);
  }

  final GetProductUseCase getProductUseCase;
  int? _currentProductId;

  Future<void> fetchProduct({
    required int productId,
    bool showLoading = true,
  }) async {
    add(ProductFetchRequested(productId: productId, showLoading: showLoading));
  }

  void refreshData({bool showLoading = true}) {
    add(ProductRefreshRequested(showLoading: showLoading));
  }

  Future<void> _onFetchRequested(
    ProductFetchRequested event,
    Emitter<ProductState> emit,
  ) async {
    _currentProductId = event.productId;

    if (event.showLoading) {
      emit(state.copyWith(status: ProductStatus.loading));
    }

    try {
      final response = await getProductUseCase(productId: event.productId);
      emit(state.copyWith(status: ProductStatus.success, product: response));
    } on Object catch (e) {
      final errorStr = e.toString();
      final userFriendlyMessage = errorStr.contains('Product not found')
          ? 'المنتج غير متوفر حالياً أو تم حذفه'
          : errorStr;

      emit(
        state.copyWith(
          status: ProductStatus.failure,
          errorMessage: userFriendlyMessage,
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    ProductRefreshRequested event,
    Emitter<ProductState> emit,
  ) async {
    if (_currentProductId != null) {
      add(
        ProductFetchRequested(
          productId: _currentProductId!,
          showLoading: event.showLoading,
        ),
      );
    }
  }
}
