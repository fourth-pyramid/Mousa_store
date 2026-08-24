import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_shadows.dart';

extension AppShadowsContextExtension on BuildContext {
  /// Accessor for shadow tokens via context
  AppShadowsTokens get shadows => const AppShadowsTokens();
}

class AppShadowsTokens {
  const AppShadowsTokens();

  List<BoxShadow> get none => AppShadows.none;
  List<BoxShadow> get subtle => AppShadows.subtle;
  List<BoxShadow> get card => AppShadows.subtle;
  List<BoxShadow> get sm => AppShadows.subtle;
  List<BoxShadow> get md => AppShadows.subtle;
}
