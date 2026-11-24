import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/service/ttl_cache.dart';
import 'package:mousa_store/core/utils/event_transformers.dart';
import 'package:mousa_store/core/utils/keyed_debouncer.dart';

void main() {
  test(
    'TTL cache deduplicates, expires and isolates catalog contexts',
    () async {
      var now = DateTime(2026);
      final cache = TtlCache<int>(now: () => now);
      var calls = 0;
      Future<int> load() async => ++calls;
      expect(await cache.get('ar-retail', load), 1);
      expect(await cache.get('ar-retail', load), 1);
      now = now.add(const Duration(minutes: 6));
      expect(await cache.get('ar-retail', load), 2);
      expect(await cache.get('en-wholesale', load), 3);
      cache.clear();
      final pending = Completer<int>();
      final first = cache.get('en-wholesale', () => pending.future);
      final second = cache.get('en-wholesale', load);
      expect(identical(first, second), isTrue);
      pending.complete(4);
      expect(await second, 4);
    },
  );
  test('late response cannot refill invalidated cache', () async {
    final cache = TtlCache<int>();
    final old = Completer<int>();
    final request = cache.get('old', () => old.future);
    cache.clear();
    expect(await cache.get('new', () async => 2), 2);
    old.complete(1);
    await request;
    expect(await cache.get('new', () async => 3), 2);
  });
  test('failed loads are not cached', () async {
    final cache = TtlCache<int>();
    await expectLater(
      cache.get('a', () async => throw StateError('offline')),
      throwsStateError,
    );
    expect(await cache.get('a', () async => 7), 7);
  });
  test('debounce restarts only the same item and cancels cleanly', () {
    fakeAsync((async) {
      final debounce = KeyedDebouncer<int>();
      final results = <String>[];
      debounce
          .wait(1, const Duration(milliseconds: 500))
          .then((v) => results.add('old:$v'));
      async.elapse(const Duration(milliseconds: 250));
      debounce
          .wait(1, const Duration(milliseconds: 500))
          .then((v) => results.add('new:$v'));
      debounce
          .wait(2, const Duration(milliseconds: 500))
          .then((v) => results.add('other:$v'));
      async.flushMicrotasks();
      expect(results, ['old:false']);
      async.elapse(const Duration(milliseconds: 500));
      expect(results, ['old:false', 'new:true', 'other:true']);
      debounce
          .wait(3, const Duration(seconds: 1))
          .then((v) => results.add('closed:$v'));
      debounce.cancelAll();
      async.flushMicrotasks();
      expect(results.last, 'closed:false');
      expect(async.pendingTimers, isEmpty);
    });
  });
  test(
    'droppable ignores overlapping requests but accepts the next one',
    () async {
      final events = StreamController<int>();
      final done = Completer<void>();
      final seen = <int>[];
      Stream<int> mapper(int event) async* {
        seen.add(event);
        if (event == 1) await done.future;
        yield event;
      }

      final output = droppable<int>()(events.stream, mapper).toList();
      events.add(1);
      events.add(2);
      await Future<void>.delayed(Duration.zero);
      expect(seen, [1]);
      done.complete();
      await Future<void>.delayed(Duration.zero);
      events.add(3);
      await events.close();
      expect(await output, [1, 3]);
    },
  );
}
