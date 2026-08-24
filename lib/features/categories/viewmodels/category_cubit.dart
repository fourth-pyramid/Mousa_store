import 'dart:async';

import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/categories/repositories/category_repo.dart';
import 'package:mousa_store/features/categories/viewmodels/category_state.dart';

class CategoryCubit extends SafeCubit<CategoryState> {
  CategoryCubit({required this.repository}) : super(const CategoryState());

  final CategoryRepo repository;

  void refreshData() => getCategories();

  Future<void> getCategories() async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final categories = await repository.fetchCategories();

      emit(
        state.copyWith(status: RequestStatus.success, categories: categories),
      );
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
