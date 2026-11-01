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
    when(() => mockService.lastIssue).thenReturn(NetworkIssue.noInterface);
    when(() => mockService.checkNow()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await stateController.close();
  });

  Widget buildTestWidget({
    required Widget child,
    EdgeInsets mediaPadding = const EdgeInsets.only(top: 44),
  }) => MediaQuery(
    data: MediaQueryData(padding: mediaPadding),
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      builder: (context, appChild) => MediaQuery(
        data: MediaQuery.of(context).copyWith(padding: mediaPadding),
        child: InternetConnectionWrapper(
          connectionService: mockService,
          child: appChild!,
        ),
      ),
      home: Scaffold(body: child),
    ),
  );

  group('InternetConnectionWrapper Widget Tests', () {
    testWidgets('Keeps banner hidden on cold start connected state', (
      tester,
    ) async {
      when(() => mockService.currentState).thenReturn(NetworkState.connected);
      when(() => mockService.lastIssue).thenReturn(NetworkIssue.none);

      await tester.pumpWidget(
        buildTestWidget(child: const Text('Main App Content')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Main App Content'), findsOneWidget);
      expect(find.textContaining('No Internet'), findsNothing);
      expect(find.textContaining('restored'), findsNothing);
    });

    testWidgets(
      'Banner message changes for noInterface, noInternet, and captivePortal',
      (tester) async {
        when(
          () => mockService.currentState,
        ).thenReturn(NetworkState.disconnected);
        when(() => mockService.lastIssue).thenReturn(NetworkIssue.noInterface);

        await tester.pumpWidget(
          buildTestWidget(child: const Text('Main App Content')),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('No Internet Connection — Try Again'),
          findsOneWidget,
        );

        // Issue changes while already disconnected -> noInternet
        when(() => mockService.lastIssue).thenReturn(NetworkIssue.noInternet);
        stateController.add(NetworkState.disconnected);
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Connected to the network but no internet — check your data balance',
          ),
          findsOneWidget,
        );

        // Issue changes while already disconnected -> captivePortal
        when(
          () => mockService.lastIssue,
        ).thenReturn(NetworkIssue.captivePortal);
        stateController.add(NetworkState.disconnected);
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Network needs sign-in or has no data balance — tap to check',
          ),
          findsOneWidget,
        );
      },
    );

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
      'Shows restored green banner on reconnect and auto-hides after 1.8 s',
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
        when(() => mockService.lastIssue).thenReturn(NetworkIssue.none);
        stateController.add(NetworkState.connected);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(
          find.text('Internet connection restored'),
          findsOneWidget,
        );

        // Advance 1800ms to trigger auto-hide timer
        await tester.pump(const Duration(milliseconds: 1800));
        await tester.pumpAndSettle();

        expect(
          find.text('Internet connection restored'),
          findsNothing,
        );
      },
    );

    testWidgets(
      'Avoids double top padding when banner is visible and preserves child state',
      (tester) async {
        when(() => mockService.currentState).thenReturn(NetworkState.connected);
        when(() => mockService.lastIssue).thenReturn(NetworkIssue.none);

        double? observedChildTopPadding;

        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                observedChildTopPadding = MediaQuery.paddingOf(context).top;
                return const Text('Main App Content');
              },
            ),
          ),
        );
        await tester.pumpAndSettle();

        // While banner is hidden, child receives the 44px top status bar padding
        expect(observedChildTopPadding, 44.0);

        // Show disconnected banner -> child top padding is removed (0.0)
        when(
          () => mockService.currentState,
        ).thenReturn(NetworkState.disconnected);
        when(() => mockService.lastIssue).thenReturn(NetworkIssue.noInterface);
        stateController.add(NetworkState.disconnected);
        await tester.pumpAndSettle();

        expect(observedChildTopPadding, 0.0);

        // Reconnect and wait for restored banner to hide -> top padding restored to 44.0
        when(() => mockService.currentState).thenReturn(NetworkState.connected);
        when(() => mockService.lastIssue).thenReturn(NetworkIssue.none);
        stateController.add(NetworkState.connected);
        await tester.pump(const Duration(milliseconds: 1900));
        await tester.pumpAndSettle();

        expect(observedChildTopPadding, 44.0);
      },
    );
  });
}
