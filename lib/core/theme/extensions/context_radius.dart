import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_radius.dart';

extension AppRadiusContextExtension on BuildContext {
  /// Accessor for radius tokens via context
  AppRadiusTokens get radius => const AppRadiusTokens();
}

class AppRadiusTokens {
  const AppRadiusTokens();

  double get xs => AppRadius.xs;
  double get sm => AppRadius.sm;
  double get md => AppRadius.md;
  double get lg => AppRadius.lg;
  double get xl => AppRadius.xl;
  double get pill => AppRadius.pill;

  BorderRadius get xsBorder => AppRadius.xsBorder;
  BorderRadius get smBorder => AppRadius.smBorder;
  BorderRadius get mdBorder => AppRadius.mdBorder;
  BorderRadius get lgBorder => AppRadius.lgBorder;
  BorderRadius get xlBorder => AppRadius.xlBorder;
  BorderRadius get pillBorder => AppRadius.pillBorder;
  BorderRadius get bottomSheet => AppRadius.bottomSheet;

  // Semantic aliases
  BorderRadius get cardBorder => AppRadius.cardBorder;
  BorderRadius get searchBorder => AppRadius.searchBorder;
  BorderRadius get chipBorder => AppRadius.chipBorder;
  BorderRadius get buttonBorder => AppRadius.buttonBorder;
  BorderRadius get dialogBorder => AppRadius.dialogBorder;
}
