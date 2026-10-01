import 'package:mousa_store/features/wholesale_or_retail/data/datasources/price_mode_local_data_source.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/repositories/price_mode_repository.dart';

class PriceModeRepositoryImpl implements PriceModeRepository {
  const PriceModeRepositoryImpl({
    required PriceModeLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final PriceModeLocalDataSource _localDataSource;

  @override
  PriceMode getPriceMode() => _localDataSource.getPriceMode();

  @override
  Future<void> setPriceMode(PriceMode mode) =>
      _localDataSource.savePriceMode(mode);
}
