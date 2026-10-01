import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_event.freezed.dart';

@freezed
sealed class BrandEvent with _$BrandEvent {
  const factory BrandEvent.fetchStarted() = BrandFetchStarted;
  const factory BrandEvent.refreshRequested() = BrandRefreshRequested;
}
