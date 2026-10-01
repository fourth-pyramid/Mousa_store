import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/brands/domain/entities/brand.dart';

part 'brand_state.freezed.dart';

enum BrandStatus { initial, loading, success, failure }

@freezed
abstract class BrandState with _$BrandState {
  const factory BrandState({
    @Default(BrandStatus.initial) BrandStatus status,
    @Default([]) List<Brand> brands,
    String? errorMessage,
  }) = _BrandState;
}
