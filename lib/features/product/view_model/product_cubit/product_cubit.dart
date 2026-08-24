import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/product/repo/product_repo.dart';
import 'package:mousa_store/features/product/view_model/product_cubit/product_state.dart';

class ProductCubit extends SafeCubit<ProductState> {
  ProductCubit({required this.repository}) : super(const ProductState());

  final ProductRepo repository;

  int? _currentProductId;

  void refreshData({bool showLoading = true}) {
    if (_currentProductId != null) {
      unawaited(fetchProduct(productId: _currentProductId!, showLoading: showLoading));
    }
  }

  Future<void> fetchProduct({
    required int productId,
    bool showLoading = true,
  }) async {
    _currentProductId = productId;

    if (showLoading) {
      emit(state.copyWith(status: ProductStatus.loading));
    }

    try {
      final response = await repository.getProduct(productId: productId);

      emit(state.copyWith(status: ProductStatus.success, product: response));
    } on Object catch (e) {
      final errorStr = e.toString();
      final userFriendlyMessage = errorStr.contains('Product not found')
          ? 'المنتج غير متوفر حالياً أو تم حذفه'
          : errorStr; // ponytail: user-friendly error message for deleted products

      emit(
        state.copyWith(
          status: ProductStatus.failure,
          errorMessage: userFriendlyMessage,
        ),
      );
      debugPrint(e.toString());
    }
  }
}
