import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_durations.dart';

extension AppDurationsContextExtension on BuildContext {
  /// Accessor for motion duration tokens via context
  AppDurationsTokens get durations => const AppDurationsTokens();
}

class AppDurationsTokens {
  const AppDurationsTokens();

  Duration get fast => AppDurations.fast;
  Duration get normal => AppDurations.pageTransition;
  Duration get pageTransition => AppDurations.pageTransition;
  Duration get bottomSheet => AppDurations.bottomSheet;
  Duration get carousel => AppDurations.carousel;
}
