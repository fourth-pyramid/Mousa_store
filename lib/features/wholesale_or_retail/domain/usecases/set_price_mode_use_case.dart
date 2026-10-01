import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/repositories/price_mode_repository.dart';

class SetPriceModeUseCase {
  const SetPriceModeUseCase(this._repository);
  final PriceModeRepository _repository;

  Future<void> call(PriceMode mode) => _repository.setPriceMode(mode);
}
