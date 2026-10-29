import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Represents the network availability and quality state.
enum NetworkState { checking, connected, unstable, disconnected }

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

  /// Returns true if connection is active and stable.
  bool get isStable;

  /// Reports HTTP latency in milliseconds from Dio interceptors.
  void reportLatency(int ms);

  /// Disposes resources, subscriptions, observers, and controllers.
  void dispose();
}

/// Configuration thresholds for latency and periodic ping.
class NetworkConfig {
  static const int pingIntervalSeconds = 5;
  static const int slowPingThresholdMs = 450;
  static const int slowDioThresholdMs = 2800;
  static const int maxSlowHits = 3;
}

/// Production implementation of [IInternetConnectionService].
///
/// Encapsulates third-party connectivity packages (`internet_connection_checker_plus`
/// and `connectivity_plus`), enforces a strict state machine, provides re-entrancy
/// protection, detects captive portals & exhausted data balance, and manages
/// lifecycle-aware periodic checks.
class InternetConnectionService
    with WidgetsBindingObserver
    implements IInternetConnectionService {
  InternetConnectionService({
    InternetConnection? internetConnection,
    Connectivity? connectivity,
    Future<int?> Function()? pingChecker,
    bool registerObserver = true,
  }) : _internetConnection = internetConnection,
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
    _listenToInternetChecker();
    unawaited(_performInitialCheck());
  }

  final InternetConnection? _internetConnection;
  final Connectivity _connectivity;
  final Future<int?> Function()? _pingChecker;
  final bool _registerObserver;

  final StreamController<NetworkState> _stateController =
      StreamController<NetworkState>.broadcast();
  final StreamController<void> _restoredController =
      StreamController<void>.broadcast();

  NetworkState _currentState = NetworkState.checking;
  int _slowHits = 0;
  bool _pingRunning = false;
  bool _isBackground = false;
  bool _isDisposed = false;
  Timer? _pingTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetStatus>? _statusSubscription;

  @override
  Stream<NetworkState> get stateStream => _stateController.stream;

  @override
  Stream<void> get connectivityRestoredStream => _restoredController.stream;

  @override
  NetworkState get currentState => _currentState;

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
      if (results.contains(ConnectivityResult.none) || results.isEmpty) {
        _slowHits = 0;
        _updateState(NetworkState.disconnected);
      } else if (!_isBackground) {
        unawaited(checkNow());
      }
    });
  }

  void _listenToInternetChecker() {
    // Only listen to InternetConnection background status changes if custom pingChecker is not provided
    if (_pingChecker != null && _internetConnection == null) return;

    final checker = _internetConnection ?? InternetConnection();
    _statusSubscription = checker.onStatusChange.listen((status) {
      if (_isBackground) return;
      switch (status) {
        case InternetStatus.connected:
          if (_currentState == NetworkState.disconnected) {
            unawaited(checkNow());
          }
        case InternetStatus.disconnected:
          _slowHits = 0;
          _updateState(NetworkState.disconnected);
      }
    });
  }

  Future<void> _performInitialCheck() async {
    await checkNow();
  }

  @override
  Future<void> checkNow() async {
    if (_pingRunning) return;
    _pingRunning = true;
    try {
      await _performCheck();
    } finally {
      _pingRunning = false;
    }
  }

  Future<int?> _checkReachability() async {
    if (_pingChecker != null) {
      final res = await _pingChecker();
      debugPrint(
        '📶 [Network Ping] Ping checker result: ${res != null ? '${res}ms' : 'FAILED'}',
      );
      return res;
    }
    try {
      final stopwatch = Stopwatch()..start();
      final checker = _internetConnection ?? InternetConnection();
      final hasAccess = await checker.hasInternetAccess;
      stopwatch.stop();
      final ms = stopwatch.elapsedMilliseconds;
      if (!hasAccess) {
        debugPrint(
          '❌ [Network Ping] Reachability FAILED (No internet access / captive portal / no quota balance)',
        );
        return null;
      }
      debugPrint('📶 [Network Ping] Reachability SUCCESS: ${ms}ms');
      return ms;
    } on Object catch (e) {
      debugPrint('❌ [Network Ping] Reachability exception: $e');
      return null;
    }
  }

  Future<void> _performCheck() async {
    if (_isDisposed) return;
    final connectivityResults = await _connectivity.checkConnectivity();
    if (_isDisposed) return;
    if (connectivityResults.contains(ConnectivityResult.none) ||
        connectivityResults.isEmpty) {
      debugPrint(
        '🔌 [Network Hardware] No active interface (WiFi/Mobile disconnected)',
      );
      _slowHits = 0;
      _updateState(NetworkState.disconnected);
      return;
    }

    final latency = await _checkReachability();
    if (_isDisposed) return;
    if (latency == null) {
      _slowHits = 0;
      _updateState(NetworkState.disconnected);
      return;
    }

    if (latency >= NetworkConfig.slowPingThresholdMs) {
      _slowHits++;
      debugPrint(
        '⚠️ [Network Ping] High ping: ${latency}ms (Threshold: ${NetworkConfig.slowPingThresholdMs}ms, Hits: $_slowHits/${NetworkConfig.maxSlowHits})',
      );
      if (_slowHits >= NetworkConfig.maxSlowHits) {
        _updateState(NetworkState.unstable);
      } else if (_currentState == NetworkState.checking ||
          _currentState == NetworkState.disconnected) {
        _updateState(NetworkState.connected);
      }
    } else {
      _slowHits = 0;
      _updateState(NetworkState.connected);
    }
  }

  @override
  void reportLatency(int ms) {
    if (_isBackground) return;
    if (_currentState == NetworkState.disconnected ||
        _currentState == NetworkState.checking) {
      return;
    }

    debugPrint('🌐 [Dio HTTP Latency] Request completed in ${ms}ms');

    if (ms >= NetworkConfig.slowDioThresholdMs) {
      _slowHits++;
      debugPrint(
        '⚠️ [Dio HTTP Latency] Slow response: ${ms}ms (Threshold: ${NetworkConfig.slowDioThresholdMs}ms, Hits: $_slowHits/${NetworkConfig.maxSlowHits})',
      );
      if (_slowHits >= NetworkConfig.maxSlowHits &&
          _currentState == NetworkState.connected) {
        _updateState(NetworkState.unstable);
      }
    } else {
      _slowHits = 0;
      if (_currentState == NetworkState.unstable) {
        _updateState(NetworkState.connected);
      }
    }
  }

  void _updateState(NetworkState nextState) {
    if (_isDisposed || _stateController.isClosed) return;
    if (_currentState == nextState) return;

    final previousState = _currentState;
    _currentState = nextState;
    debugPrint(
      '🔄 [Network State Changed] ${previousState.name} ➔ ${nextState.name}',
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

    if (nextState == NetworkState.disconnected) {
      _stopPingCheck();
    } else if (!_isBackground) {
      _startPingCheck();
    }
  }

  void _startPingCheck() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(
      const Duration(seconds: NetworkConfig.pingIntervalSeconds),
      (_) {
        if (!_isBackground && _currentState != NetworkState.disconnected) {
          unawaited(checkNow());
        }
      },
    );
  }

  void _stopPingCheck() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _isBackground = true;
        _stopPingCheck();
      case AppLifecycleState.resumed:
        _isBackground = false;
        unawaited(checkNow());
        if (_currentState == NetworkState.connected ||
            _currentState == NetworkState.unstable) {
          _startPingCheck();
        }
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
    _stopPingCheck();
    unawaited(_connectivitySubscription?.cancel());
    _connectivitySubscription = null;
    unawaited(_statusSubscription?.cancel());
    _statusSubscription = null;
    unawaited(_stateController.close());
    unawaited(_restoredController.close());
  }
}
