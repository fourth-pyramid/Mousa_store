import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

/// Represents the network availability and quality state.
enum NetworkState { checking, connected, unstable, disconnected }

/// Classifies the root cause of a network issue when reachability is degraded
/// or unavailable.
enum NetworkIssue {
  /// Connection is healthy and verified.
  none,

  /// OS reports no active network interface (WiFi / Mobile Data off).
  noInterface,

  /// Interface is active, but real internet endpoints cannot be reached
  /// (e.g. exhausted mobile data balance, dead router uplink, blocked traffic).
  noInternet,

  /// An intermediate server intercepted the probe (3xx redirect or 2xx with
  /// unexpected body, typical of captive portals or carrier billing pages).
  captivePortal,
}

/// Abstract contract for the enterprise internet connection service.
abstract interface class IInternetConnectionService {
  /// Stream emitting continuous network state changes.
  Stream<NetworkState> get stateStream;

  /// Fires only when transitioning from disconnected to connected.
  Stream<void> get connectivityRestoredStream;

  /// Checks if network connection is available.
  Future<bool> hasConnection();

  /// Forces an immediate active network check.
  Future<void> checkNow();

  /// Returns the current known network state.
  NetworkState get currentState;

  /// Returns the latest classified network issue.
  NetworkIssue get lastIssue;

  /// Returns true if connection is active and stable.
  bool get isStable;

  /// Reports HTTP latency in milliseconds from Dio interceptors.
  void reportLatency(int ms);

  /// Reports a real network failure (timeout or connection error) from Dio
  /// so the service can immediately re-verify reachability.
  void reportRequestFailure();

  /// Disposes resources, subscriptions, observers, and controllers.
  void dispose();
}

/// Configuration thresholds for latency, backoff, and reachability probes.
class NetworkConfig {
  static const int pingIntervalSeconds = 5;
  static const List<int> recoveryBackoffSeconds = [2, 4, 6, 10, 15];
  static const int slowPingThresholdMs = 700;
  static const int slowDioThresholdMs = 2800;
  static const int maxSlowHits = 3;
  static const Duration slowHttpDecay = Duration(seconds: 30);
  static const int failuresBeforeDisconnect = 2;
  static const int requiredProbeSuccesses = 2;
  static const Duration probeTimeout = Duration(seconds: 4);
  static const Duration failureCheckDebounce = Duration(seconds: 3);
}

/// Defines a single HTTPS reachability probe endpoint and its strict validator.
class ProbeTarget {
  const ProbeTarget(this.uri, this.isValid);

  final Uri uri;
  final bool Function(int statusCode, String body) isValid;
}

/// Outcome category for an individual [ReachabilityProbe.run] invocation.
enum ProbeOutcome { ok, portal, failed }

/// Result of probing a single [ProbeTarget].
class ProbeResult {
  const ProbeResult._({
    required this.outcome,
    this.latencyMs,
  });

  const ProbeResult.ok(int latencyMs)
      : this._(outcome: ProbeOutcome.ok, latencyMs: latencyMs);

  const ProbeResult.portal() : this._(outcome: ProbeOutcome.portal);

  const ProbeResult.failed() : this._(outcome: ProbeOutcome.failed);

  final ProbeOutcome outcome;
  final int? latencyMs;

  bool get isOk => outcome == ProbeOutcome.ok;
  bool get isPortal => outcome == ProbeOutcome.portal;
  bool get isFailed => outcome == ProbeOutcome.failed;
}

/// Aggregated result of probing all configured endpoints in parallel.
class ProbeSummary {
  const ProbeSummary({
    required this.isSuccess,
    required this.issue,
    required this.results,
    this.latencyMs,
  });

  final bool isSuccess;
  final int? latencyMs;
  final NetworkIssue issue;
  final List<ProbeResult> results;
}

/// Verifies real internet access using HTTPS endpoints with strict response
/// validation (status code + body content, no redirects).
///
/// Note: Uses `dart:io` [HttpClient] and is supported on mobile and desktop
/// platforms only (not Flutter web).
///
/// Custom [targets] can be injected via the constructor so the application can
/// include its own backend health endpoint alongside the default probes.
class ReachabilityProbe {
  /// Creates a [ReachabilityProbe].
  ///
  /// Pass [targets] to customize or extend the probe endpoints (for example,
  /// to include the application's own backend health check endpoint).
  ReachabilityProbe({
    List<ProbeTarget>? targets,
    HttpClient? httpClient,
    this.timeout = NetworkConfig.probeTimeout,
    this.requiredSuccesses = NetworkConfig.requiredProbeSuccesses,
  }) : targets = List<ProbeTarget>.unmodifiable(targets ?? defaultTargets),
       _client = httpClient ?? _createDefaultClient(timeout);

  static const int _maxBodyBytes = 4096;

  /// Default HTTPS-only reachability targets (Android 9+ and iOS ATS block
  /// cleartext HTTP by default).
  static final List<ProbeTarget> defaultTargets =
      List<ProbeTarget>.unmodifiable([
        ProbeTarget(
          Uri.parse('https://cp.cloudflare.com/generate_204'),
          (statusCode, _) => statusCode == 204,
        ),
        ProbeTarget(
          Uri.parse('https://www.gstatic.com/generate_204'),
          (statusCode, _) => statusCode == 204,
        ),
        ProbeTarget(
          Uri.parse('https://captive.apple.com/hotspot-detect.html'),
          (statusCode, body) => statusCode == 200 && body.contains('Success'),
        ),
      ]);

  static HttpClient _createDefaultClient(Duration timeout) => HttpClient()
    ..connectionTimeout = timeout
    ..idleTimeout = const Duration(seconds: 30)
    ..userAgent = 'MousaStore-ReachabilityProbe/1.0';

  final List<ProbeTarget> targets;
  final HttpClient _client;
  final Duration timeout;
  final int requiredSuccesses;

  int _primaryIndex = 0;

  /// Index of the endpoint that responded fastest in the most recent
  /// successful full check.
  int get primaryIndex => _primaryIndex;

  /// Executes a single probe against [target] with redirects disabled and
  /// strict status/body validation.
  Future<ProbeResult> run(ProbeTarget target) async {
    HttpClientRequest? request;
    try {
      final stopwatch = Stopwatch()..start();
      request = (await _client.getUrl(target.uri).timeout(timeout))
        ..followRedirects = false
        ..headers.set(HttpHeaders.cacheControlHeader, 'no-cache');

      final response = await request.close().timeout(timeout);
      stopwatch.stop();
      final latencyMs = stopwatch.elapsedMilliseconds;

      final bytes = <int>[];
      await for (final chunk in response.timeout(timeout)) {
        final remaining = _maxBodyBytes - bytes.length;
        if (remaining <= 0) {
          break;
        }
        if (chunk.length <= remaining) {
          bytes.addAll(chunk);
        } else {
          bytes.addAll(chunk.sublist(0, remaining));
          break;
        }
      }
      final body = utf8.decode(bytes, allowMalformed: true);
      final statusCode = response.statusCode;

      if (statusCode >= 300 && statusCode < 400) {
        return const ProbeResult.portal();
      }
      if (target.isValid(statusCode, body)) {
        return ProbeResult.ok(latencyMs);
      }
      if (statusCode >= 200 && statusCode < 300) {
        return const ProbeResult.portal();
      }
      return const ProbeResult.failed();
    } on Object catch (_) {
      try {
        request?.abort();
      } on Object catch (_) {
        // Ignore abort errors
      }
      return const ProbeResult.failed();
    }
  }

  /// Probes only the endpoint that was fastest in the last successful full
  /// check (initially index 0).
  Future<ProbeResult> runPrimary() {
    if (targets.isEmpty) {
      return Future<ProbeResult>.value(const ProbeResult.failed());
    }
    final index = _primaryIndex.clamp(0, targets.length - 1);
    return run(targets[index]);
  }

  /// Probes all [targets] in parallel and requires at least
  /// `min(requiredSuccesses, targets.length)` endpoints to succeed.
  Future<ProbeSummary> runAll() async {
    if (targets.isEmpty) {
      return const ProbeSummary(
        isSuccess: false,
        issue: NetworkIssue.noInternet,
        results: [],
      );
    }

    final results = await Future.wait(targets.map(run));
    final okLatencies = <int>[];
    var fastestIndex = _primaryIndex;
    int? fastestLatency;

    for (var i = 0; i < results.length; i++) {
      final result = results[i];
      if (result.isOk && result.latencyMs != null) {
        final latency = result.latencyMs!;
        okLatencies.add(latency);
        if (fastestLatency == null || latency < fastestLatency) {
          fastestLatency = latency;
          fastestIndex = i;
        }
      }
    }

    final needed = math.min(requiredSuccesses, targets.length);
    if (okLatencies.length >= needed) {
      _primaryIndex = fastestIndex;
      okLatencies.sort();
      final mid = okLatencies.length ~/ 2;
      final medianLatency = okLatencies.length.isOdd
          ? okLatencies[mid]
          : (okLatencies[mid - 1] + okLatencies[mid]) ~/ 2;

      return ProbeSummary(
        isSuccess: true,
        latencyMs: medianLatency,
        issue: NetworkIssue.none,
        results: results,
      );
    }

    final hasPortal = results.any((r) => r.isPortal);
    return ProbeSummary(
      isSuccess: false,
      issue: hasPortal ? NetworkIssue.captivePortal : NetworkIssue.noInternet,
      results: results,
    );
  }

  /// Closes the underlying [HttpClient] and terminates any active sockets.
  void close() {
    _client.close(force: true);
  }
}

/// Production implementation of [IInternetConnectionService].
///
/// Combines OS interface monitoring (`connectivity_plus`) with multi-endpoint
/// HTTPS reachability verification ([ReachabilityProbe]) to accurately detect
/// captive portals, exhausted mobile data balances, and dead router uplinks,
/// while actively recovering via exponential backoff while offline.
class InternetConnectionService
    with WidgetsBindingObserver
    implements IInternetConnectionService {
  InternetConnectionService({
    ReachabilityProbe? probe,
    Connectivity? connectivity,
    Future<int?> Function()? pingChecker,
    bool registerObserver = true,
  }) : _probe = probe ?? ReachabilityProbe(),
       _connectivity = connectivity ?? Connectivity(),
       _pingChecker = pingChecker,
       _registerObserver = registerObserver {
    if (_registerObserver) {
      try {
        WidgetsBinding.instance.addObserver(this);
      } on Object catch (_) {
        // Ignored when running outside Flutter binding context
      }
    }
    _listenToConnectivity();
    unawaited(checkNow());
  }

  final ReachabilityProbe _probe;
  final Connectivity _connectivity;
  final Future<int?> Function()? _pingChecker;
  final bool _registerObserver;

  final StreamController<NetworkState> _stateController =
      StreamController<NetworkState>.broadcast();
  final StreamController<void> _restoredController =
      StreamController<void>.broadcast();

  NetworkState _currentState = NetworkState.checking;
  NetworkIssue _lastIssue = NetworkIssue.none;
  NetworkIssue _lastEmittedIssue = NetworkIssue.none;

  int _slowPingHits = 0;
  int _slowHttpHits = 0;
  DateTime? _lastSlowHttpAt;
  Timer? _slowHttpDecayTimer;

  int _consecutiveFailures = 0;
  int _recoveryAttempt = 0;
  bool _forceConsensus = true;

  Future<void>? _inFlight;
  bool _recheck = false;
  int _epoch = 0;

  DateTime? _lastFailureCheckAt;
  Timer? _failureDebounceTimer;

  bool _isBackground = false;
  bool _isDisposed = false;
  Timer? _timer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  Stream<NetworkState> get stateStream => _stateController.stream;

  @override
  Stream<void> get connectivityRestoredStream => _restoredController.stream;

  @override
  NetworkState get currentState => _currentState;

  @override
  NetworkIssue get lastIssue => _lastIssue;

  @override
  bool get isStable => _currentState == NetworkState.connected;

  @override
  Future<bool> hasConnection() async {
    if (_currentState == NetworkState.checking) {
      await checkNow();
    }
    return _currentState == NetworkState.connected ||
        _currentState == NetworkState.unstable;
  }

  void _listenToConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (_isDisposed) return;
      _epoch++;
      _forceConsensus = true;

      if (results.isEmpty || results.contains(ConnectivityResult.none)) {
        _recheck = false;
        _lastIssue = NetworkIssue.noInterface;
        _updateState(NetworkState.disconnected);
        _scheduleNext();
      } else {
        _recheck = true;
        if (!_isBackground) {
          unawaited(checkNow());
        }
      }
    });
  }

  @override
  Future<void> checkNow() =>
      _inFlight ??= _runChecks().whenComplete(() => _inFlight = null);

  Future<void> _runChecks() async {
    var completedEpoch = false;
    try {
      do {
        _recheck = false;
        completedEpoch = await _performCheck();
      } while (_recheck && !_isDisposed);
    } finally {
      if (completedEpoch) {
        _scheduleNext();
      }
    }
  }

  Future<({bool ok, int? latencyMs, NetworkIssue issue})> _evaluateReachability({
    required bool useFullCheck,
    required int startEpoch,
  }) async {
    if (_pingChecker != null) {
      try {
        final ms = await _pingChecker();
        debugPrint(
          '📶 [Network Ping] Ping checker result: ${ms != null ? '${ms}ms' : 'FAILED'}',
        );
        if (ms != null) {
          return (ok: true, latencyMs: ms, issue: NetworkIssue.none);
        }
        return (ok: false, latencyMs: null, issue: NetworkIssue.noInternet);
      } on Object catch (e) {
        debugPrint('❌ [Network Ping] Ping checker exception: $e');
        return (ok: false, latencyMs: null, issue: NetworkIssue.noInternet);
      }
    }

    if (!useFullCheck) {
      final primary = await _probe.runPrimary();
      if (_isDisposed || _epoch != startEpoch) {
        return (ok: false, latencyMs: null, issue: NetworkIssue.noInternet);
      }
      if (primary.isOk && primary.latencyMs != null) {
        debugPrint(
          '📶 [Network Probe] Primary probe SUCCESS: ${primary.latencyMs}ms',
        );
        return (
          ok: true,
          latencyMs: primary.latencyMs,
          issue: NetworkIssue.none,
        );
      }
      debugPrint(
        '⚠️ [Network Probe] Primary probe failed (${primary.outcome.name}); falling back to consensus check',
      );
    }

    final summary = await _probe.runAll();
    if (summary.isSuccess && summary.latencyMs != null) {
      debugPrint(
        '📶 [Network Probe] Consensus SUCCESS (median ${summary.latencyMs}ms)',
      );
      return (
        ok: true,
        latencyMs: summary.latencyMs,
        issue: NetworkIssue.none,
      );
    }

    debugPrint(
      '❌ [Network Probe] Consensus FAILED (issue: ${summary.issue.name})',
    );
    return (ok: false, latencyMs: null, issue: summary.issue);
  }

  Future<bool> _performCheck() async {
    if (_isDisposed) return false;
    final startEpoch = _epoch;

    List<ConnectivityResult> connectivityResults;
    try {
      connectivityResults = await _connectivity.checkConnectivity();
    } on Object catch (e) {
      debugPrint('❌ [Network Hardware] Connectivity check error: $e');
      connectivityResults = const [ConnectivityResult.none];
    }

    if (_isDisposed || _epoch != startEpoch) return false;

    if (connectivityResults.isEmpty ||
        connectivityResults.contains(ConnectivityResult.none)) {
      debugPrint(
        '🔌 [Network Hardware] No active interface (WiFi/Mobile disconnected)',
      );
      _lastIssue = NetworkIssue.noInterface;
      _slowPingHits = 0;
      _consecutiveFailures = 0;
      _updateState(NetworkState.disconnected);
      return true;
    }

    final useFullCheck =
        _currentState == NetworkState.checking ||
        _currentState == NetworkState.disconnected ||
        _forceConsensus;

    final outcome = await _evaluateReachability(
      useFullCheck: useFullCheck,
      startEpoch: startEpoch,
    );

    if (_isDisposed || _epoch != startEpoch) return false;

    if (!outcome.ok) {
      _lastIssue = outcome.issue;
      _slowPingHits = 0;
      _consecutiveFailures++;
      final wasOnline =
          _currentState == NetworkState.connected ||
          _currentState == NetworkState.unstable;
      final requiredFailures = wasOnline
          ? NetworkConfig.failuresBeforeDisconnect
          : 1;
      if (_consecutiveFailures >= requiredFailures) {
        _updateState(NetworkState.disconnected);
      }
      return true;
    }

    _consecutiveFailures = 0;
    _forceConsensus = false;
    _lastIssue = NetworkIssue.none;
    _recoveryAttempt = 0;

    final latency = outcome.latencyMs!;
    if (latency >= NetworkConfig.slowPingThresholdMs) {
      _slowPingHits++;
      debugPrint(
        '⚠️ [Network Ping] High ping: ${latency}ms (Threshold: ${NetworkConfig.slowPingThresholdMs}ms, Hits: $_slowPingHits/${NetworkConfig.maxSlowHits})',
      );
    } else {
      _slowPingHits = 0;
    }

    _applyStability();
    return true;
  }

  void _applyStability() {
    if (_lastSlowHttpAt != null &&
        DateTime.now().difference(_lastSlowHttpAt!) >=
            NetworkConfig.slowHttpDecay) {
      _slowHttpHits = 0;
      _lastSlowHttpAt = null;
      _slowHttpDecayTimer?.cancel();
      _slowHttpDecayTimer = null;
    }

    if (_slowPingHits >= NetworkConfig.maxSlowHits ||
        _slowHttpHits >= NetworkConfig.maxSlowHits) {
      _updateState(NetworkState.unstable);
    } else {
      _updateState(NetworkState.connected);
    }
  }

  @override
  void reportLatency(int ms) {
    if (_isBackground || _isDisposed) return;
    if (_currentState == NetworkState.disconnected ||
        _currentState == NetworkState.checking) {
      return;
    }

    debugPrint('🌐 [Dio HTTP Latency] Request completed in ${ms}ms');

    if (ms >= NetworkConfig.slowDioThresholdMs) {
      _slowHttpHits++;
      _lastSlowHttpAt = DateTime.now();
      _slowHttpDecayTimer?.cancel();
      _slowHttpDecayTimer = Timer(NetworkConfig.slowHttpDecay, () {
        _lastSlowHttpAt = DateTime.fromMillisecondsSinceEpoch(0);
      });
      debugPrint(
        '⚠️ [Dio HTTP Latency] Slow response: ${ms}ms (Threshold: ${NetworkConfig.slowDioThresholdMs}ms, Hits: $_slowHttpHits/${NetworkConfig.maxSlowHits})',
      );
    } else {
      _slowHttpHits = 0;
      _lastSlowHttpAt = null;
      _slowHttpDecayTimer?.cancel();
      _slowHttpDecayTimer = null;
    }

    _applyStability();
  }

  @override
  void reportRequestFailure() {
    if (_isBackground ||
        _isDisposed ||
        _currentState == NetworkState.disconnected) {
      return;
    }

    final now = DateTime.now();
    if (_lastFailureCheckAt != null &&
        now.difference(_lastFailureCheckAt!) <
            NetworkConfig.failureCheckDebounce) {
      return;
    }

    _lastFailureCheckAt = now;
    _failureDebounceTimer?.cancel();
    _failureDebounceTimer = Timer(NetworkConfig.failureCheckDebounce, () {
      _lastFailureCheckAt = null;
    });

    _forceConsensus = true;
    unawaited(checkNow());
  }

  void _scheduleNext() {
    _cancelTimer();
    if (_isBackground || _isDisposed) return;

    final Duration delay;
    if (_currentState == NetworkState.disconnected) {
      const backoff = NetworkConfig.recoveryBackoffSeconds;
      final index = math.min(_recoveryAttempt, backoff.length - 1);
      _recoveryAttempt++;
      delay = Duration(seconds: backoff[index]);
    } else if (_consecutiveFailures > 0) {
      delay = const Duration(seconds: 1);
    } else {
      delay = const Duration(seconds: NetworkConfig.pingIntervalSeconds);
    }

    _timer = Timer(delay, () {
      if (!_isBackground && !_isDisposed) {
        unawaited(checkNow());
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateState(NetworkState nextState) {
    if (_isDisposed || _stateController.isClosed) return;
    if (_currentState == nextState) {
      if (nextState == NetworkState.disconnected &&
          _lastIssue != _lastEmittedIssue) {
        _lastEmittedIssue = _lastIssue;
        _stateController.add(nextState);
      }
      return;
    }

    final previousState = _currentState;
    _currentState = nextState;
    _lastEmittedIssue = _lastIssue;

    if (nextState == NetworkState.disconnected) {
      _slowPingHits = 0;
      _slowHttpHits = 0;
      _lastSlowHttpAt = null;
      _slowHttpDecayTimer?.cancel();
      _slowHttpDecayTimer = null;
      _recoveryAttempt = 0;
      _consecutiveFailures = 0;
      _forceConsensus = true;
    }

    debugPrint(
      '🔄 [Network State Changed] ${previousState.name} ➔ ${nextState.name} (issue: ${_lastIssue.name})',
    );
    if (!_stateController.isClosed) {
      _stateController.add(nextState);
    }

    // Fired strictly when transitioning from disconnected to connected
    if (previousState == NetworkState.disconnected &&
        nextState == NetworkState.connected &&
        !_restoredController.isClosed) {
      _restoredController.add(null);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _isBackground = true;
        _cancelTimer();
      case AppLifecycleState.resumed:
        _isBackground = false;
        _forceConsensus = true;
        _recheck = true;
        unawaited(checkNow());
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    if (_registerObserver) {
      try {
        WidgetsBinding.instance.removeObserver(this);
      } on Object catch (_) {
        // Ignored
      }
    }
    _cancelTimer();
    _slowHttpDecayTimer?.cancel();
    _slowHttpDecayTimer = null;
    _failureDebounceTimer?.cancel();
    _failureDebounceTimer = null;
    unawaited(_connectivitySubscription?.cancel());
    _connectivitySubscription = null;
    _probe.close();
    unawaited(_stateController.close());
    unawaited(_restoredController.close());
  }
}
