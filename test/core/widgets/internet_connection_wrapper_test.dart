import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/widgets/internet_connection_wrapper.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class MockInternetConnectionService extends Mock
    implements IInternetConnectionService {}

void main() {
  late MockInternetConnectionService mockService;
  late StreamController<NetworkState> stateController;

  setUp(() {
    mockService = MockInternetConnectionService();
    stateController = StreamController<NetworkState>.broadcast();

    when(
      () => mockService.stateStream,
    ).thenAnswer((_) => stateController.stream);
    when(() => mockService.checkNow()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await stateController.close();
  });

  Widget buildTestWidget({required Widget child}) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(
      body: InternetConnectionWrapper(
        connectionService: mockService,
        child: child,
      ),
    ),
  );

  group('InternetConnectionWrapper Widget Tests', () {
    testWidgets('Keeps banner hidden on cold start connected state', (
      tester,
    ) async {
      when(() => mockService.currentState).thenReturn(NetworkState.connected);

      await tester.pumpWidget(
        buildTestWidget(child: const Text('Main App Content')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Main App Content'), findsOneWidget);
      expect(find.textContaining('No Internet'), findsNothing);
      expect(find.textContaining('restored'), findsNothing);
    });

    testWidgets('Displays red offline banner when state is disconnected', (
      tester,
    ) async {
      when(
        () => mockService.currentState,
      ).thenReturn(NetworkState.disconnected);

      await tester.pumpWidget(
        buildTestWidget(child: const Text('Main App Content')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Main App Content'), findsOneWidget);
      expect(find.textContaining('No Internet Connection'), findsOneWidget);
    });

    testWidgets('Invokes checkNow on tapping disconnected banner', (
      tester,
    ) async {
      when(
        () => mockService.currentState,
      ).thenReturn(NetworkState.disconnected);

      await tester.pumpWidget(
        buildTestWidget(child: const Text('Main App Content')),
      );
      await tester.pumpAndSettle();

      final bannerFinder = find.byType(InkWell);
      expect(bannerFinder, findsOneWidget);

      await tester.tap(bannerFinder);
      await tester.pump();

      verify(() => mockService.checkNow()).called(1);
    });

    testWidgets(
      'Shows restored green banner on reconnect and auto-hides after ~1800ms',
      (tester) async {
        when(
          () => mockService.currentState,
        ).thenReturn(NetworkState.disconnected);

        await tester.pumpWidget(
          buildTestWidget(child: const Text('Main App Content')),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('No Internet Connection'), findsOneWidget);

        // Transition from disconnected -> connected
        stateController.add(NetworkState.connected);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(
          find.textContaining('Internet connection restored'),
          findsOneWidget,
        );

        // Advance 1900ms to trigger auto-hide timer
        await tester.pump(const Duration(milliseconds: 1900));
        await tester.pumpAndSettle();

        expect(
          find.textContaining('Internet connection restored'),
          findsNothing,
        );
      },
    );
  });
}
