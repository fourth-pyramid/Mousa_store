import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:mousa_store/features/categories/models/category.dart';

enum RequestStatus { initial, loading, success, failure }

@immutable
class CategoryState extends Equatable {
  const CategoryState({
    this.status = RequestStatus.initial,
    this.categories = const [],
    this.errorMessage,
  });

  final RequestStatus status;
  final List<Category> categories;
  final String? errorMessage;

  CategoryState copyWith({
    RequestStatus? status,
    List<Category>? categories,
    String? errorMessage,
  }) => CategoryState(
    status: status ?? this.status,
    categories: categories ?? this.categories,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, categories, errorMessage];
}
