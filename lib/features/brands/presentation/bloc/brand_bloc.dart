import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/brands/domain/usecases/get_brands_use_case.dart';
import 'package:mousa_store/features/brands/presentation/bloc/brand_event.dart';
import 'package:mousa_store/features/brands/presentation/bloc/brand_state.dart';

export 'brand_event.dart';
export 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc({required this.getBrandsUseCase}) : super(const BrandState()) {
    on<BrandFetchStarted>(_onBrandFetchStarted);
    on<BrandRefreshRequested>(_onBrandRefreshRequested);
  }

  final GetBrandsUseCase getBrandsUseCase;

  Future<void> _onBrandFetchStarted(
    BrandFetchStarted event,
    Emitter<BrandState> emit,
  ) async {
    emit(state.copyWith(status: BrandStatus.loading));
    try {
      final brands = await getBrandsUseCase();
      emit(state.copyWith(status: BrandStatus.success, brands: brands));
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: BrandStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onBrandRefreshRequested(
    BrandRefreshRequested event,
    Emitter<BrandState> emit,
  ) async {
    emit(state.copyWith(status: BrandStatus.loading));
    try {
      final brands = await getBrandsUseCase();
      emit(state.copyWith(status: BrandStatus.success, brands: brands));
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: BrandStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
