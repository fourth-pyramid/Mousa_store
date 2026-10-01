import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';
import 'package:mousa_store/features/profile/presentation/widgets/theme_selection_sheet.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/theme_bloc.dart';
import 'package:mousa_store/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _buildTestWidget({required ThemeBloc themeBloc}) => ScreenUtilInit(
  designSize: const Size(375, 812),
  builder: (_, _) => BlocProvider<ThemeBloc>.value(
    value: themeBloc,
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

  late ThemeBloc themeBloc;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    themeBloc = ThemeBloc(ThemeMode.light);
  });

  tearDown(() async {
    await themeBloc.close();
  });

  group('ThemeSelectionSheet Widget Tests', () {
    testWidgets('renders all three theme options', (tester) async {
      await tester.pumpWidget(_buildTestWidget(themeBloc: themeBloc));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
      expect(find.byIcon(Icons.phone_android_outlined), findsOneWidget);
    });

    testWidgets('switching theme option changes theme state', (tester) async {
      await tester.pumpWidget(_buildTestWidget(themeBloc: themeBloc));
      await tester.pumpAndSettle();

      // Initially light mode
      expect(themeBloc.state.themeMode, equals(ThemeMode.light));

      // Tap dark mode option
      await tester.tap(find.byIcon(Icons.dark_mode_outlined));
      await tester.pumpAndSettle();

      expect(themeBloc.state.themeMode, equals(ThemeMode.dark));
    });
  });
}
