import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';

part 'price_mode_state.freezed.dart';

@freezed
sealed class PriceModeState with _$PriceModeState {
  const factory PriceModeState({
    required PriceMode mode,
  }) = _PriceModeState;
}
