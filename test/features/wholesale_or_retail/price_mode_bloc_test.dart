import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/wholesale_or_retail/data/datasources/price_mode_local_data_source.dart';
import 'package:mousa_store/features/wholesale_or_retail/data/repositories/price_mode_repository_impl.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/usecases/get_price_mode_use_case.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/usecases/set_price_mode_use_case.dart';
import 'package:mousa_store/features/wholesale_or_retail/presentation/bloc/price_mode_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GetPriceModeUseCase getPriceModeUseCase;
  late SetPriceModeUseCase setPriceModeUseCase;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    DioHelper.init();
    const localDataSource = PriceModeLocalDataSourceImpl();
    const repository = PriceModeRepositoryImpl(localDataSource: localDataSource);
    getPriceModeUseCase = const GetPriceModeUseCase(repository);
    setPriceModeUseCase = const SetPriceModeUseCase(repository);
  });

  group('PriceModeBloc Tests', () {
    test('initial state defaults to wholesale', () async {
      final bloc = PriceModeBloc(
        getPriceModeUseCase: getPriceModeUseCase,
        setPriceModeUseCase: setPriceModeUseCase,
      );
      expect(bloc.state.mode, equals(PriceMode.wholesale));
      await bloc.close();
    });

    blocTest<PriceModeBloc, PriceModeState>(
      'emits updated mode when PriceModeEvent.modeChanged is added',
      build: () => PriceModeBloc(
        getPriceModeUseCase: getPriceModeUseCase,
        setPriceModeUseCase: setPriceModeUseCase,
      ),
      act: (bloc) => bloc.add(const PriceModeEvent.modeChanged(PriceMode.retail)),
      expect: () => [
        const PriceModeState(mode: PriceMode.retail),
      ],
    );

    blocTest<PriceModeBloc, PriceModeState>(
      'emits current mode when PriceModeEvent.started is added',
      build: () => PriceModeBloc(
        getPriceModeUseCase: getPriceModeUseCase,
        setPriceModeUseCase: setPriceModeUseCase,
      ),
      act: (bloc) => bloc.add(const PriceModeEvent.started()),
      expect: () => [
        const PriceModeState(mode: PriceMode.wholesale),
      ],
    );
  });
}
