import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mousa_store/features/brands/models/brand.dart';

enum RequestStatus { initial, loading, success, failure }

@immutable
class BrandState extends Equatable {
  const BrandState({
    this.status = RequestStatus.initial,
    this.brands = const [],
    this.errorMessage,
  });

  final RequestStatus status;
  final List<Brand> brands;
  final String? errorMessage;

  BrandState copyWith({
    RequestStatus? status,
    List<Brand>? brands,
    String? errorMessage,
  }) => BrandState(
    status: status ?? this.status,
    brands: brands ?? this.brands,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, brands, errorMessage];
}
