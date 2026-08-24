import 'dart:async';

import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/core/utils/safe_cubit.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';

enum PriceMode { wholesale, retail }

class PriceModeState {
  PriceModeState(this.mode);
  final PriceMode mode;
}

class PriceModeCubit extends SafeCubit<PriceModeState> {
  PriceModeCubit() : super(PriceModeState(_getInitialMode()));

  static PriceMode _getInitialMode() {
    final modeString = CacheHelper.getPriceMode();
    if (modeString == 'retail') {
      return PriceMode.retail;
    }
    return PriceMode.wholesale; // Default
  }

  void setPriceMode(PriceMode mode) {
    final modeString = mode == PriceMode.wholesale ? 'wholesale' : 'retail';
    DioHelper.setPriceMode(modeString);
    unawaited(CacheHelper.savePriceMode(modeString));

    // ponytail: skip auth-required endpoints when user is not logged in
    if (CacheHelper.getToken() != null) {
      unawaited(getIt<FavoriteCubit>().getFavorites());
      unawaited(getIt<CartCubit>().getCart());
    }

    emit(PriceModeState(mode));
  }
}
