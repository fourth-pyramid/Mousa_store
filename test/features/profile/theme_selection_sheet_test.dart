import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/features/profile/widget/theme_selection_sheet.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';
import 'package:mousa_store/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildTestWidget({required ThemeCubit themeCubit}) => ScreenUtilInit(
  designSize: const Size(375, 812),
  builder: (_, _) => BlocProvider<ThemeCubit>.value(
    value: themeCubit,
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      home: Scaffold(body: ThemeSelectionSheet()),
    ),
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ThemeCubit themeCubit;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    themeCubit = ThemeCubit(ThemeMode.light);
  });

  tearDown(() async {
    await themeCubit.close();
  });

  group('ThemeSelectionSheet Widget Tests', () {
    testWidgets('renders all three theme options', (tester) async {
      await tester.pumpWidget(_buildTestWidget(themeCubit: themeCubit));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.phone_android_outlined), findsOneWidget);
    });

    testWidgets('switching theme option changes theme state', (tester) async {
      await tester.pumpWidget(_buildTestWidget(themeCubit: themeCubit));
      await tester.pumpAndSettle();

      // Initially light mode
      expect(themeCubit.state.themeMode, equals(ThemeMode.light));

      // Tap dark mode option
      await tester.tap(find.byIcon(Icons.dark_mode_outlined));
      await tester.pumpAndSettle();

      expect(themeCubit.state.themeMode, equals(ThemeMode.dark));
    });
  });
}
