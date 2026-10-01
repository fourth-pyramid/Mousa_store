import 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/repositories/price_mode_repository.dart';

class GetPriceModeUseCase {
  const GetPriceModeUseCase(this._repository);
  final PriceModeRepository _repository;

  PriceMode call() => _repository.getPriceMode();
}
