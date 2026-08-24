import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    DioHelper.init();
  });

  group('PriceModeCubit Tests', () {
    test('initial state defaults to wholesale', () async {
      final cubit = PriceModeCubit();
      expect(cubit.state.mode, equals(PriceMode.wholesale));
      await cubit.close();
    });

    test('setPriceMode updates state to retail and changes mode', () async {
      final cubit = PriceModeCubit()
        ..setPriceMode(PriceMode.retail);
      expect(cubit.state.mode, equals(PriceMode.retail));

      cubit.setPriceMode(PriceMode.wholesale);
      expect(cubit.state.mode, equals(PriceMode.wholesale));

      await cubit.close();
    });
  });
}
