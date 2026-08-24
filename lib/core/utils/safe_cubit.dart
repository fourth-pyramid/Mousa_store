import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

/// A mixin that ensures [emit] is only called when the [Cubit] is not closed.
mixin SafeEmitMixin<State> on Cubit<State> {
  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }
}

/// A base [Cubit] class that prevents "Cannot emit new states after calling close"
/// error by safely ignoring any [emit] calls if the cubit is closed.
abstract class SafeCubit<State> extends Cubit<State> with SafeEmitMixin<State> {
  SafeCubit(super.initialState);
}
