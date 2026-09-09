import 'dart:async';

import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/brands/repositories/brand_repo.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_state.dart';

class BrandCubit extends SafeCubit<BrandState> {
  BrandCubit({required this.repository}) : super(const BrandState());

  final BrandRepo repository;

  void refreshData() => getBrands();

  Future<void> getBrands() async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final brands = await repository.fetchBrands();

      emit(state.copyWith(status: RequestStatus.success, brands: brands));
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
