import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/categories/domain/entities/category.dart';

part 'category_state.freezed.dart';

enum CategoryStatus { initial, loading, success, failure }

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(CategoryStatus.initial) CategoryStatus status,
    @Default([]) List<Category> categories,
    String? errorMessage,
  }) = _CategoryState;
}
