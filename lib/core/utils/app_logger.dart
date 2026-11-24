import 'package:flutter/foundation.dart';

/// Development diagnostics only. Never log credentials or personal payloads.
abstract final class AppLogger {
  static void debug(String? message, {int? wrapWidth}) {
    if (kReleaseMode) return;
    debugPrint(message, wrapWidth: wrapWidth);
  }
}
