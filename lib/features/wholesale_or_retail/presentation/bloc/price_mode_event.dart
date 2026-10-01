import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';

part 'price_mode_event.freezed.dart';

@freezed
sealed class PriceModeEvent with _$PriceModeEvent {
  const factory PriceModeEvent.started() = PriceModeStarted;
  const factory PriceModeEvent.modeChanged(PriceMode mode) = PriceModeChanged;
}
