import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/features/auth/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    await CacheHelper.init();
  });

  group('CacheHelper Tests', () {
    test('isFirstOpen and setFirstOpenDone works as expected', () async {
      expect(CacheHelper.isFirstOpen(), isTrue);

      final result = await CacheHelper.setFirstOpenDone();
      expect(result, isTrue);
      expect(CacheHelper.isFirstOpen(), isFalse);
    });

    test(
      'savePriceMode and getPriceMode stores and retrieves properly',
      () async {
        expect(CacheHelper.getPriceMode(), isNull);

        final result = await CacheHelper.savePriceMode('wholesale');
        expect(result, isTrue);
        expect(CacheHelper.getPriceMode(), equals('wholesale'));
      },
    );

    test(
      'saveUser and getUser stores in memory and returns cached user',
      () async {
        final user = User(
          id: 42,
          firstName: 'Ahmed',
          lastName: 'Ali',
          email: 'ahmed@example.com',
          phone: '01234567890',
          userType: 'customer',
          isVerified: true,
        );

        final saved = await CacheHelper.saveUser(user);
        expect(saved, isTrue);

        final cachedUser = CacheHelper.getUser();
        expect(cachedUser, isNotNull);
        expect(cachedUser?.id, equals(42));
        expect(cachedUser?.firstName, equals('Ahmed'));
        expect(cachedUser?.email, equals('ahmed@example.com'));

        await CacheHelper.clearUser();
        expect(CacheHelper.getUser(), isNull);
      },
    );

    test(
      'clearAll clears user and tokens while preserving preferences',
      () async {
        await CacheHelper.setFirstOpenDone();
        await CacheHelper.savePriceMode('retail');

        final user = User(
          id: 1,
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          phone: '01000000000',
          userType: 'customer',
          isVerified: true,
        );
        await CacheHelper.saveUser(user);
        expect(CacheHelper.getUser(), isNotNull);

        await CacheHelper.clearAll();

        expect(CacheHelper.getUser(), isNull);
        expect(CacheHelper.getToken(), isNull);
        // preserved across logouts
        expect(CacheHelper.isFirstOpen(), isFalse);
        expect(CacheHelper.getPriceMode(), equals('retail'));
      },
    );
  });
}
