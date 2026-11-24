import 'dart:async';

/// Restart the wait for one key without cancelling work for other keys.
/// Cancellation completes the previous wait, so event handlers never hang.
class KeyedDebouncer<K> {
  final _timers = <K, Timer>{};
  final _waiters = <K, Completer<bool>>{};

  Future<bool> wait(K key, Duration delay) {
    cancel(key);
    final waiter = Completer<bool>();
    _waiters[key] = waiter;
    _timers[key] = Timer(delay, () {
      _timers.remove(key);
      _waiters.remove(key);
      waiter.complete(true);
    });
    return waiter.future;
  }

  void cancel(K key) {
    _timers.remove(key)?.cancel();
    _waiters.remove(key)?.complete(false);
  }

  void cancelAll() {
    for (final key in _waiters.keys.toList()) {
      cancel(key);
    }
  }
}
