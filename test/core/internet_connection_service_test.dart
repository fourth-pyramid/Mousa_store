// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';

class FakeConnectivity implements Connectivity {
  FakeConnectivity({
    List<ConnectivityResult> initial = const [ConnectivityResult.wifi],
  }) : currentResults = initial;

  List<ConnectivityResult> currentResults;
  final StreamController<List<ConnectivityResult>> controller =
      StreamController<List<ConnectivityResult>>.broadcast();

  void emit(List<ConnectivityResult> results) {
    currentResults = results;
    controller.add(results);
  }

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => currentResults;

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      controller.stream;

  Future<void> dispose() => controller.close();
}

class FakeReachabilityProbe implements ReachabilityProbe {
  int runPrimaryCalls = 0;
  int runAllCalls = 0;
  bool isClosed = false;

  Future<ProbeResult> Function()? onRunPrimary;
  Future<ProbeSummary> Function()? onRunAll;

  @override
  List<ProbeTarget> get targets => ReachabilityProbe.defaultTargets;

  @override
  Duration get timeout => NetworkConfig.probeTimeout;

  @override
  int get requiredSuccesses => NetworkConfig.requiredProbeSuccesses;

  @override
  int get primaryIndex => 0;

  @override
  Future<ProbeResult> run(ProbeTarget target) async =>
      const ProbeResult.ok(40);

  @override
  Future<ProbeResult> runPrimary() async {
    runPrimaryCalls++;
    if (onRunPrimary != null) {
      return onRunPrimary!();
    }
    return const ProbeResult.ok(40);
  }

  @override
  Future<ProbeSummary> runAll() async {
    runAllCalls++;
    if (onRunAll != null) {
      return onRunAll!();
    }
    return const ProbeSummary(
      isSuccess: true,
      latencyMs: 40,
      issue: NetworkIssue.none,
      results: [ProbeResult.ok(40), ProbeResult.ok(40)],
    );
  }

  @override
  void close() {
    isClosed = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeConnectivity fakeConnectivity;
  late FakeReachabilityProbe fakeProbe;

  setUp(() {
    HttpOverrides.global = null;
    fakeConnectivity = FakeConnectivity();
    fakeProbe = FakeReachabilityProbe();
  });

  tearDown(() async {
    await fakeConnectivity.dispose();
  });

  group('InternetConnectionService Tests', () {
    test(
      'Interface up + all probes fail -> disconnected with lastIssue == noInternet',
      () {
        fakeAsync((async) {
          fakeProbe.onRunAll = () async => const ProbeSummary(
            isSuccess: false,
            issue: NetworkIssue.noInternet,
            results: [ProbeResult.failed(), ProbeResult.failed()],
          );

          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );

          expect(service.currentState, NetworkState.checking);
          async.flushMicrotasks();

          expect(service.currentState, NetworkState.disconnected);
          expect(service.lastIssue, NetworkIssue.noInternet);
          expect(service.isStable, isFalse);

          service.dispose();
        });
      },
    );

    test('Probes return portal -> lastIssue == captivePortal', () {
      fakeAsync((async) {
        fakeProbe.onRunAll = () async => const ProbeSummary(
          isSuccess: false,
          issue: NetworkIssue.captivePortal,
          results: [ProbeResult.portal(), ProbeResult.failed()],
        );

        final service = InternetConnectionService(
          connectivity: fakeConnectivity,
          probe: fakeProbe,
          registerObserver: false,
        );

        async.flushMicrotasks();

        expect(service.currentState, NetworkState.disconnected);
        expect(service.lastIssue, NetworkIssue.captivePortal);

        service.dispose();
      });
    });

    test(
      'Connected, one failed check -> still connected; second consecutive failure -> disconnected',
      () {
        fakeAsync((async) {
          var shouldSucceed = true;
          fakeProbe
            ..onRunPrimary = () async {
              if (shouldSucceed) return const ProbeResult.ok(50);
              return const ProbeResult.failed();
            }
            ..onRunAll = () async {
              if (shouldSucceed) {
                return const ProbeSummary(
                  isSuccess: true,
                  latencyMs: 50,
                  issue: NetworkIssue.none,
                  results: [ProbeResult.ok(50), ProbeResult.ok(50)],
                );
              }
              return const ProbeSummary(
                isSuccess: false,
                issue: NetworkIssue.noInternet,
                results: [ProbeResult.failed(), ProbeResult.failed()],
              );
            };

          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );

          async.flushMicrotasks();
          expect(service.currentState, NetworkState.connected);

          // Now fail probes; first check failure at 5s keeps state connected
          shouldSucceed = false;
          async.elapse(const Duration(seconds: 5));
          expect(service.currentState, NetworkState.connected);
          expect(service.lastIssue, NetworkIssue.noInternet);

          // Second consecutive failure scheduled 1s later -> disconnected
          async.elapse(const Duration(seconds: 1));
          expect(service.currentState, NetworkState.disconnected);
          expect(service.lastIssue, NetworkIssue.noInternet);

          service.dispose();
        });
      },
    );

    test(
      'Disconnected -> probe succeeds on a later timer tick (no connectivity event) -> connected and connectivityRestoredStream fires once',
      () {
        fakeAsync((async) {
          var shouldSucceed = false;
          var restoredCount = 0;

          fakeProbe.onRunAll = () async {
            if (shouldSucceed) {
              return const ProbeSummary(
                isSuccess: true,
                latencyMs: 45,
                issue: NetworkIssue.none,
                results: [ProbeResult.ok(45), ProbeResult.ok(45)],
              );
            }
            return const ProbeSummary(
              isSuccess: false,
              issue: NetworkIssue.noInternet,
              results: [ProbeResult.failed(), ProbeResult.failed()],
            );
          };

          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );
          service.connectivityRestoredStream.listen((_) => restoredCount++);

          async.flushMicrotasks();
          expect(service.currentState, NetworkState.disconnected);
          expect(restoredCount, 0);

          // First recovery tick at 2s still fails
          async.elapse(const Duration(seconds: 2));
          expect(service.currentState, NetworkState.disconnected);
          expect(restoredCount, 0);

          // User tops up balance (no OS connectivity event); next recovery tick at 4s succeeds
          shouldSucceed = true;
          async.elapse(const Duration(seconds: 4));

          expect(service.currentState, NetworkState.connected);
          expect(service.lastIssue, NetworkIssue.none);
          expect(restoredCount, 1);

          // Subsequent healthy ticks do not re-fire connectivityRestoredStream
          async.elapse(const Duration(seconds: 10));
          expect(restoredCount, 1);

          service.dispose();
        });
      },
    );

    test('Backoff schedule while disconnected: ticks at 2, 4, 6, 10, 15, 15 s', () {
      fakeAsync((async) {
        final checkTimes = <int>[];
        var elapsedSeconds = 0;

        fakeProbe.onRunAll = () async {
          checkTimes.add(elapsedSeconds);
          return const ProbeSummary(
            isSuccess: false,
            issue: NetworkIssue.noInternet,
            results: [ProbeResult.failed(), ProbeResult.failed()],
          );
        };

        final service = InternetConnectionService(
          connectivity: fakeConnectivity,
          probe: fakeProbe,
          registerObserver: false,
        );

        async.flushMicrotasks();
        expect(checkTimes, [0]);

        for (var s = 1; s <= 52; s++) {
          elapsedSeconds = s;
          async.elapse(const Duration(seconds: 1));
        }

        // Expected cumulative tick times: 0, 2, 6 (2+4), 12 (6+6), 22 (12+10), 37 (22+15), 52 (37+15)
        expect(checkTimes, [0, 2, 6, 12, 22, 37, 52]);

        service.dispose();
      });
    });

    test(
      'Slow pings and slow HTTP hits are counted separately; fast ping does not clear HTTP hits; HTTP hits decay after 30 s; unstable -> connected only when both are clear',
      () {
        fakeAsync((async) {
          var pingLatency = 50;
          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            pingChecker: () async => pingLatency,
            registerObserver: false,
          );

          async.flushMicrotasks();
          expect(service.currentState, NetworkState.connected);

          // 3 slow HTTP hits -> unstable
          service
            ..reportLatency(NetworkConfig.slowDioThresholdMs)
            ..reportLatency(NetworkConfig.slowDioThresholdMs)
            ..reportLatency(NetworkConfig.slowDioThresholdMs);
          expect(service.currentState, NetworkState.unstable);

          // A fast ping at 5s does NOT clear slow HTTP hits -> still unstable
          pingLatency = 40;
          async.elapse(const Duration(seconds: 5));
          expect(service.currentState, NetworkState.unstable);

          // Drive slow ping hits to 3 as well (at 10s, 15s, 20s)
          pingLatency = NetworkConfig.slowPingThresholdMs + 100;
          async.elapse(const Duration(seconds: 15));
          expect(service.currentState, NetworkState.unstable);

          // Fast HTTP request clears HTTP hits, but slow ping hits are still >= 3 -> still unstable
          service.reportLatency(100);
          expect(service.currentState, NetworkState.unstable);

          // Fast ping clears ping hits -> both clear -> connected
          pingLatency = 40;
          async.elapse(const Duration(seconds: 5));
          expect(service.currentState, NetworkState.connected);

          // Now trigger 3 slow HTTP hits again -> unstable, then let them decay after 30s without any fast HTTP hit
          service
            ..reportLatency(NetworkConfig.slowDioThresholdMs)
            ..reportLatency(NetworkConfig.slowDioThresholdMs)
            ..reportLatency(NetworkConfig.slowDioThresholdMs);
          expect(service.currentState, NetworkState.unstable);

          // Before 30s (at 25s), fast pings still keep it unstable
          async.elapse(const Duration(seconds: 25));
          expect(service.currentState, NetworkState.unstable);

          // At 30s, slow HTTP hits have decayed and the fast ping transitions back to connected
          async.elapse(const Duration(seconds: 5));
          expect(service.currentState, NetworkState.connected);

          service.dispose();
        });
      },
    );

    test(
      'hasConnection() called during initial check awaits and returns true; concurrent checkNow() calls share one in-flight future',
      () {
        fakeAsync((async) {
          final completer = Completer<ProbeSummary>();
          fakeProbe.onRunAll = () => completer.future;

          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );

          expect(service.currentState, NetworkState.checking);

          bool? hasConnResult;
          unawaited(
            service.hasConnection().then((value) => hasConnResult = value),
          );
          final check1 = service.checkNow();
          final check2 = service.checkNow();

          var checksDone = false;
          unawaited(
            Future.wait([check1, check2]).then((_) => checksDone = true),
          );

          async.flushMicrotasks();
          expect(hasConnResult, isNull);
          expect(fakeProbe.runAllCalls, 1);

          completer.complete(
            const ProbeSummary(
              isSuccess: true,
              latencyMs: 30,
              issue: NetworkIssue.none,
              results: [ProbeResult.ok(30), ProbeResult.ok(30)],
            ),
          );
          async.flushMicrotasks();

          expect(hasConnResult, isTrue);
          expect(checksDone, isTrue);
          expect(fakeProbe.runAllCalls, 1);
          expect(service.currentState, NetworkState.connected);

          service.dispose();
        });
      },
    );

    test(
      'Network switch mid-check discards stale result and runs a new check',
      () {
        fakeAsync((async) {
          final firstCheckCompleter = Completer<ProbeSummary>();
          var callNumber = 0;

          fakeProbe.onRunAll = () {
            callNumber++;
            if (callNumber == 1) {
              return firstCheckCompleter.future;
            }
            return Future<ProbeSummary>.value(
              const ProbeSummary(
                isSuccess: true,
                latencyMs: 35,
                issue: NetworkIssue.none,
                results: [ProbeResult.ok(35), ProbeResult.ok(35)],
              ),
            );
          };

          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );

          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, 1);

          // Switch from WiFi to Mobile while first check is still pending
          fakeConnectivity.emit([ConnectivityResult.mobile]);
          async.flushMicrotasks();

          // First check completes with a failure (from the old WiFi interface)
          firstCheckCompleter.complete(
            const ProbeSummary(
              isSuccess: false,
              issue: NetworkIssue.noInternet,
              results: [ProbeResult.failed(), ProbeResult.failed()],
            ),
          );
          async.flushMicrotasks();

          // Stale failure was discarded and second check succeeded
          expect(fakeProbe.runAllCalls, 2);
          expect(service.currentState, NetworkState.connected);
          expect(service.lastIssue, NetworkIssue.none);

          service.dispose();
        });
      },
    );

    test(
      'reportRequestFailure() triggers a consensus check, debounced within 3 s, and ignored while disconnected',
      () {
        fakeAsync((async) {
          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );

          async.flushMicrotasks();
          expect(service.currentState, NetworkState.connected);
          expect(fakeProbe.runAllCalls, 1);

          // First failure triggers immediate consensus check (runAll)
          service.reportRequestFailure();
          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, 2);

          // Within 3s debounce window -> ignored
          async.elapse(const Duration(seconds: 1));
          service.reportRequestFailure();
          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, 2);

          // After 3s total elapsed -> allowed again
          async.elapse(const Duration(seconds: 2));
          service.reportRequestFailure();
          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, 3);

          // Disconnect hardware -> reportRequestFailure is ignored while disconnected
          fakeConnectivity.emit([ConnectivityResult.none]);
          async.flushMicrotasks();
          expect(service.currentState, NetworkState.disconnected);

          // Advance past the 3s debounce window while disconnected and call reportRequestFailure()
          async.elapse(const Duration(seconds: 3));
          final callsWhileOffline = fakeProbe.runAllCalls;
          service.reportRequestFailure();
          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, callsWhileOffline);

          service.dispose();
        });
      },
    );

    test(
      'Lifecycle: paused/hidden cancel timer; resumed triggers check; inactive does nothing',
      () {
        fakeAsync((async) {
          final service = InternetConnectionService(
            connectivity: fakeConnectivity,
            probe: fakeProbe,
            registerObserver: false,
          );

          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, 1);
          expect(fakeProbe.runPrimaryCalls, 0);

          // inactive does NOT stop the periodic timer
          service.didChangeAppLifecycleState(AppLifecycleState.inactive);
          async.elapse(const Duration(seconds: 5));
          expect(fakeProbe.runPrimaryCalls, 1);

          // paused stops the timer
          service.didChangeAppLifecycleState(AppLifecycleState.paused);
          async.elapse(const Duration(seconds: 20));
          expect(fakeProbe.runPrimaryCalls, 1);
          expect(fakeProbe.runAllCalls, 1);

          // resumed triggers an immediate consensus check and restarts timer
          service.didChangeAppLifecycleState(AppLifecycleState.resumed);
          async.flushMicrotasks();
          expect(fakeProbe.runAllCalls, 2);

          // hidden also stops the timer
          service.didChangeAppLifecycleState(AppLifecycleState.hidden);
          async.elapse(const Duration(seconds: 20));
          expect(fakeProbe.runPrimaryCalls, 1);
          expect(fakeProbe.runAllCalls, 2);

          service.dispose();
        });
      },
    );

    test('dispose() is idempotent, closes probe and streams', () async {
      final service = InternetConnectionService(
        connectivity: fakeConnectivity,
        probe: fakeProbe,
        registerObserver: false,
      );

      var stateStreamDone = false;
      var restoredStreamDone = false;
      service.stateStream.listen(
        (_) {},
        onDone: () => stateStreamDone = true,
      );
      service.connectivityRestoredStream.listen(
        (_) {},
        onDone: () => restoredStreamDone = true,
      );

      service
        ..dispose()
        ..dispose();

      await Future<void>.delayed(Duration.zero);

      expect(fakeProbe.isClosed, isTrue);
      expect(stateStreamDone, isTrue);
      expect(restoredStreamDone, isTrue);
    });
  });

  group('ReachabilityProbe Strict Validation Tests', () {
    test(
      'Validates 204 -> ok, 302 -> portal, 200 wrong body -> portal, 500 -> failed, timeout -> failed',
      () async {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));

        server.listen((request) async {
          switch (request.uri.path) {
            case '/204':
              request.response.statusCode = 204;
              await request.response.close();
            case '/302':
              request.response.statusCode = 302;
              request.response.headers.set(
                HttpHeaders.locationHeader,
                'http://portal.local/login',
              );
              await request.response.close();
            case '/200-wrong':
              request.response.statusCode = 200;
              request.response.write('<html>Please login to WiFi</html>');
              await request.response.close();
            case '/500':
              request.response.statusCode = 500;
              await request.response.close();
            case '/timeout':
              // Hold the request open longer than probe timeout
              await Future<void>.delayed(const Duration(milliseconds: 500));
              try {
                request.response.statusCode = 204;
                await request.response.close();
              } on Object catch (_) {
                // Client already aborted
              }
          }
        });

        final base = 'http://${server.address.address}:${server.port}';
        final probe = ReachabilityProbe(
          timeout: const Duration(milliseconds: 120),
        );
        addTearDown(probe.close);

        final res204 = await probe.run(
          ProbeTarget(Uri.parse('$base/204'), (code, _) => code == 204),
        );
        final res302 = await probe.run(
          ProbeTarget(Uri.parse('$base/302'), (code, _) => code == 204),
        );
        final res200Wrong = await probe.run(
          ProbeTarget(
            Uri.parse('$base/200-wrong'),
            (code, body) => code == 200 && body.contains('Success'),
          ),
        );
        final res500 = await probe.run(
          ProbeTarget(Uri.parse('$base/500'), (code, _) => code == 204),
        );
        final resTimeout = await probe.run(
          ProbeTarget(Uri.parse('$base/timeout'), (code, _) => code == 204),
        );

        expect(res204.isOk, isTrue);
        expect(res302.isPortal, isTrue);
        expect(res200Wrong.isPortal, isTrue);
        expect(res500.isFailed, isTrue);
        expect(resTimeout.isFailed, isTrue);
      },
    );

    test(
      'runAll() requires 2 of 3 consensus, returns median latency, and updates primaryIndex to fastest',
      () async {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));

        server.listen((request) async {
          switch (request.uri.path) {
            case '/slow':
              await Future<void>.delayed(const Duration(milliseconds: 90));
              request.response.statusCode = 204;
              await request.response.close();
            case '/fast':
              await Future<void>.delayed(const Duration(milliseconds: 10));
              request.response.statusCode = 200;
              request.response.write('<HTML><BODY>Success</BODY></HTML>');
              await request.response.close();
            case '/medium':
              await Future<void>.delayed(const Duration(milliseconds: 45));
              request.response.statusCode = 204;
              await request.response.close();
            case '/portal':
              request.response.statusCode = 302;
              await request.response.close();
            default:
              request.response.statusCode = 500;
              await request.response.close();
          }
        });

        final base = 'http://${server.address.address}:${server.port}';
        final probe3Ok = ReachabilityProbe(
          targets: [
            ProbeTarget(Uri.parse('$base/slow'), (code, _) => code == 204),
            ProbeTarget(
              Uri.parse('$base/fast'),
              (code, body) => code == 200 && body.contains('Success'),
            ),
            ProbeTarget(Uri.parse('$base/medium'), (code, _) => code == 204),
          ],
        );
        addTearDown(probe3Ok.close);

        final summary = await probe3Ok.runAll();
        expect(summary.isSuccess, isTrue);
        expect(summary.issue, NetworkIssue.none);
        // Target 1 (/fast) should be selected as the new primary
        expect(probe3Ok.primaryIndex, 1);

        // Verify median calculation: sorted latencies[1]
        final sortedLatencies =
            summary.results.map((r) => r.latencyMs!).toList()..sort();
        expect(summary.latencyMs, sortedLatencies[1]);

        // Now test 1 ok + 1 portal + 1 fail -> fails consensus with captivePortal
        final probeFailConsensus = ReachabilityProbe(
          targets: [
            ProbeTarget(Uri.parse('$base/fast'), (code, _) => code == 200),
            ProbeTarget(Uri.parse('$base/portal'), (code, _) => code == 204),
            ProbeTarget(Uri.parse('$base/error'), (code, _) => code == 204),
          ],
        );
        addTearDown(probeFailConsensus.close);

        final failSummary = await probeFailConsensus.runAll();
        expect(failSummary.isSuccess, isFalse);
        expect(failSummary.issue, NetworkIssue.captivePortal);
      },
    );
  });
}
