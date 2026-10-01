import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';

abstract class PriceModeLocalDataSource {
  PriceMode getPriceMode();
  Future<void> savePriceMode(PriceMode mode);
}

class PriceModeLocalDataSourceImpl implements PriceModeLocalDataSource {
  const PriceModeLocalDataSourceImpl();

  @override
  PriceMode getPriceMode() {
    final modeString = CacheHelper.getPriceMode();
    if (modeString == 'retail') {
      return PriceMode.retail;
    }
    return PriceMode.wholesale;
  }

  @override
  Future<void> savePriceMode(PriceMode mode) async {
    final modeString = mode == PriceMode.wholesale ? 'wholesale' : 'retail';
    DioHelper.setPriceMode(modeString);
    await CacheHelper.savePriceMode(modeString);
  }
}
