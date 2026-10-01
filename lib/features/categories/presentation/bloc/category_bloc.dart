import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:mousa_store/features/categories/presentation/bloc/category_event.dart';
import 'package:mousa_store/features/categories/presentation/bloc/category_state.dart';

export 'category_event.dart';
export 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.getCategoriesUseCase})
      : super(const CategoryState()) {
    on<CategoryFetchStarted>(_onCategoryFetchStarted);
    on<CategoryRefreshRequested>(_onCategoryRefreshRequested);
  }

  final GetCategoriesUseCase getCategoriesUseCase;

  Future<void> _onCategoryFetchStarted(
    CategoryFetchStarted event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final categories = await getCategoriesUseCase();
      emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: categories,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCategoryRefreshRequested(
    CategoryRefreshRequested event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final categories = await getCategoriesUseCase();
      emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: categories,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
