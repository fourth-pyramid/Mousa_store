import 'dart:async';

/// Ignore overlapping events until the mapped operation finishes.
/// Unlike asyncExpand, events are dropped rather than queued.
Stream<E> Function(Stream<E>, Stream<E> Function(E)) droppable<E>() =>
    (events, mapper) {
      late StreamController<E> controller;
      StreamSubscription<E>? source;
      StreamSubscription<E>? active;
      var busy = false;
      var sourceDone = false;
      controller = StreamController<E>(
        sync: true,
        onListen: () {
          source = events.listen(
            (event) {
              if (busy) return;
              busy = true;
              active = mapper(event).listen(
                controller.add,
                onError: controller.addError,
                onDone: () {
                  busy = false;
                  active = null;
                  if (sourceDone) unawaited(controller.close());
                },
              );
            },
            onError: controller.addError,
            onDone: () {
              sourceDone = true;
              if (!busy) unawaited(controller.close());
            },
          );
        },
        onCancel: () async {
          await source?.cancel();
          await active?.cancel();
        },
      );
      return controller.stream;
    };
