import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/usecases/get_price_mode_use_case.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/usecases/set_price_mode_use_case.dart';
import 'package:mousa_store/features/wholesale_or_retail/presentation/bloc/price_mode_event.dart';
import 'package:mousa_store/features/wholesale_or_retail/presentation/bloc/price_mode_state.dart';

export 'package:mousa_store/features/wholesale_or_retail/domain/entities/price_mode.dart';
export 'package:mousa_store/features/wholesale_or_retail/presentation/bloc/price_mode_event.dart';
export 'package:mousa_store/features/wholesale_or_retail/presentation/bloc/price_mode_state.dart';

class PriceModeBloc extends Bloc<PriceModeEvent, PriceModeState> {
  PriceModeBloc({
    required GetPriceModeUseCase getPriceModeUseCase,
    required SetPriceModeUseCase setPriceModeUseCase,
  })  : _getPriceModeUseCase = getPriceModeUseCase,
        _setPriceModeUseCase = setPriceModeUseCase,
        super(PriceModeState(mode: getPriceModeUseCase())) {
    on<PriceModeStarted>(_onStarted);
    on<PriceModeChanged>(_onModeChanged);
  }

  final GetPriceModeUseCase _getPriceModeUseCase;
  final SetPriceModeUseCase _setPriceModeUseCase;

  void _onStarted(
    PriceModeStarted event,
    Emitter<PriceModeState> emit,
  ) {
    final currentMode = _getPriceModeUseCase();
    emit(state.copyWith(mode: currentMode));
  }

  Future<void> _onModeChanged(
    PriceModeChanged event,
    Emitter<PriceModeState> emit,
  ) async {
    unawaited(_setPriceModeUseCase(event.mode));

    // skip auth-required endpoints when user is not logged in
    if (CacheHelper.getToken() != null) {
      getIt<FavoriteBloc>().add(const FavoritesFetchRequested());
      getIt<CartBloc>().add(const CartFetchRequested());
    }

    emit(state.copyWith(mode: event.mode));
  }
}
