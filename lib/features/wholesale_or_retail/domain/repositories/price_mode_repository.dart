import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';

abstract class PriceModeRepository {
  PriceMode getPriceMode();
  Future<void> setPriceMode(PriceMode mode);
}
