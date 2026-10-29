import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockConnectivity mockConnectivity;
  late StreamController<List<ConnectivityResult>> connectivityStreamController;

  setUp(() {
    mockConnectivity = MockConnectivity();
    connectivityStreamController =
        StreamController<List<ConnectivityResult>>.broadcast();

    when(
      () => mockConnectivity.onConnectivityChanged,
    ).thenAnswer((_) => connectivityStreamController.stream);
    when(
      () => mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });

  tearDown(() async {
    await connectivityStreamController.close();
  });

  group('InternetConnectionService Tests', () {
    test(
      'Initial state is checking and resolves to connected without firing restored stream',
      () async {
        var restoredFired = false;
        final service = InternetConnectionService(
          connectivity: mockConnectivity,
          pingChecker: () async => 50,
          registerObserver: false,
        );

        expect(service.currentState, NetworkState.checking);

        service.connectivityRestoredStream.listen((_) {
          restoredFired = true;
        });

        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(service.currentState, NetworkState.connected);
        expect(service.isStable, isTrue);
        expect(restoredFired, isFalse);

        service.dispose();
      },
    );

    test('Initial state resolves to disconnected when ping fails', () async {
      final service = InternetConnectionService(
        connectivity: mockConnectivity,
        pingChecker: () async => null,
        registerObserver: false,
      );

      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(service.currentState, NetworkState.disconnected);
      expect(service.isStable, isFalse);
      expect(await service.hasConnection(), isFalse);

      service.dispose();
    });

    test(
      'Hardware disconnect transitions to disconnected and stops periodic ping',
      () async {
        var pingCount = 0;
        final service = InternetConnectionService(
          connectivity: mockConnectivity,
          pingChecker: () async {
            pingCount++;
            return 80;
          },
          registerObserver: false,
        );

        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(service.currentState, NetworkState.connected);
        final initialPings = pingCount;

        connectivityStreamController.add([ConnectivityResult.none]);
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(service.currentState, NetworkState.disconnected);

        // Verify periodic ping is stopped while disconnected
        await Future<void>.delayed(const Duration(seconds: 6));
        expect(pingCount, initialPings);

        service.dispose();
      },
    );

    test(
      'Reconnecting from disconnected transitions to connected and fires connectivityRestoredStream',
      () async {
        var restoredCount = 0;
        var pingSucceeds = false;

        final service = InternetConnectionService(
          connectivity: mockConnectivity,
          pingChecker: () async => pingSucceeds ? 60 : null,
          registerObserver: false,
        );

        service.connectivityRestoredStream.listen((_) {
          restoredCount++;
        });

        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(service.currentState, NetworkState.disconnected);
        expect(restoredCount, 0);

        // Turn on connection and ping success
        pingSucceeds = true;
        await service.checkNow();
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(service.currentState, NetworkState.connected);
        expect(restoredCount, 1);

        service.dispose();
      },
    );

    test('3 consecutive slow hits trigger NetworkState.unstable', () async {
      final service = InternetConnectionService(
        connectivity: mockConnectivity,
        pingChecker: () async => 50,
        registerObserver: false,
      );

      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(service.currentState, NetworkState.connected);

      // Report 2 slow Dio hits (>= 2800ms)
      service.reportLatency(NetworkConfig.slowDioThresholdMs);
      expect(service.currentState, NetworkState.connected);

      service.reportLatency(NetworkConfig.slowDioThresholdMs + 100);
      expect(service.currentState, NetworkState.connected);

      // 3rd slow hit
      service.reportLatency(NetworkConfig.slowDioThresholdMs);
      expect(service.currentState, NetworkState.unstable);
      expect(service.isStable, isFalse);

      service.dispose();
    });

    test(
      'Single fast hit after instability recovers to NetworkState.connected',
      () async {
        final service = InternetConnectionService(
          connectivity: mockConnectivity,
          pingChecker: () async => 50,
          registerObserver: false,
        );

        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Drive to unstable
        service
          ..reportLatency(NetworkConfig.slowDioThresholdMs)
          ..reportLatency(NetworkConfig.slowDioThresholdMs)
          ..reportLatency(NetworkConfig.slowDioThresholdMs);
        expect(service.currentState, NetworkState.unstable);

        // Single fast hit recovers
        service.reportLatency(200);
        expect(service.currentState, NetworkState.connected);
        expect(service.isStable, isTrue);

        service.dispose();
      },
    );

    test('Lifecycle paused stops pings; resumed triggers checkNow()', () async {
      var pingCalls = 0;
      final service = InternetConnectionService(
        connectivity: mockConnectivity,
        pingChecker: () async {
          pingCalls++;
          return 70;
        },
        registerObserver: false,
      );

      await Future<void>.delayed(const Duration(milliseconds: 50));
      final callsAfterStart = pingCalls;

      // Simulate lifecycle pause
      service
        ..didChangeAppLifecycleState(AppLifecycleState.paused)
        ..reportLatency(NetworkConfig.slowDioThresholdMs)
        ..reportLatency(NetworkConfig.slowDioThresholdMs)
        ..reportLatency(NetworkConfig.slowDioThresholdMs);
      expect(service.currentState, NetworkState.connected);

      // Simulate lifecycle resume
      service.didChangeAppLifecycleState(AppLifecycleState.resumed);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(pingCalls, greaterThan(callsAfterStart));

      service.dispose();
    });

    test('Re-entrancy lock prevents parallel ping executions', () async {
      var concurrentCalls = 0;
      var maxConcurrentCalls = 0;

      final service = InternetConnectionService(
        connectivity: mockConnectivity,
        pingChecker: () async {
          concurrentCalls++;
          if (concurrentCalls > maxConcurrentCalls) {
            maxConcurrentCalls = concurrentCalls;
          }
          await Future<void>.delayed(const Duration(milliseconds: 80));
          concurrentCalls--;
          return 60;
        },
        registerObserver: false,
      );

      // Trigger multiple checkNow concurrently
      await Future.wait([
        service.checkNow(),
        service.checkNow(),
        service.checkNow(),
      ]);

      expect(maxConcurrentCalls, 1);

      service.dispose();
    });

    test(
      'WiFi connected but no data quota (captive portal) resolves to disconnected, then recovers',
      () async {
        final mockInternet = MockInternetConnection();
        final statusStreamController =
            StreamController<InternetStatus>.broadcast();
        var hasAccess = false;

        when(
          () => mockInternet.onStatusChange,
        ).thenAnswer((_) => statusStreamController.stream);
        when(
          () => mockInternet.hasInternetAccess,
        ).thenAnswer((_) async => hasAccess);

        var restoredFired = false;
        final service = InternetConnectionService(
          connectivity: mockConnectivity,
          internetConnection: mockInternet,
          registerObserver: false,
        );

        service.connectivityRestoredStream.listen((_) {
          restoredFired = true;
        });

        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Hardware is WiFi, but hasInternetAccess is false (no data balance)
        expect(service.currentState, NetworkState.disconnected);
        expect(service.isStable, isFalse);
        expect(restoredFired, isFalse);

        // User buys a package -> hasInternetAccess becomes true
        hasAccess = true;
        statusStreamController.add(InternetStatus.connected);
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(service.currentState, NetworkState.connected);
        expect(service.isStable, isTrue);
        expect(restoredFired, isTrue);

        await statusStreamController.close();
        service.dispose();
      },
    );
  });
}
