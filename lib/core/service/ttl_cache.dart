/// A small in-memory TTL cache. Failed refreshes never replace cached data.
class TtlCache<T> {
  TtlCache({this.ttl = const Duration(minutes: 5), DateTime Function()? now})
    : _now = now ?? DateTime.now;
  final Duration ttl;
  final DateTime Function() _now;
  T? _value;
  DateTime? _expiresAt;
  String? _key;
  Future<T>? _inFlight;
  int _generation = 0;

  void clear() {
    _generation++;
    _value = null;
    _expiresAt = null;
    _key = null;
    _inFlight = null;
  }

  Future<T> get(String key, Future<T> Function() load) {
    if (_key != key) {
      clear();
      _key = key;
    }
    if (_value != null && _expiresAt != null && _now().isBefore(_expiresAt!)) {
      return Future.value(_value);
    }
    final pending = _inFlight;
    if (pending != null) return pending;
    final generation = _generation;
    final future = Future<T>.sync(load)
        .then((value) {
          if (_generation == generation) {
            _value = value;
            _expiresAt = _now().add(ttl);
          }
          return value;
        })
        .whenComplete(() {
          if (_generation == generation) _inFlight = null;
        });
    _inFlight = future;
    return future;
  }
}
