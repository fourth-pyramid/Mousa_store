import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_spacing.dart';

extension AppSpacingContextExtension on BuildContext {
  /// Accessor for spacing tokens via context
  AppSpacingTokens get spacing => const AppSpacingTokens();
}

class AppSpacingTokens {
  const AppSpacingTokens();

  double get xxs => AppSpacing.xxs;
  double get xs => AppSpacing.xs;
  double get sm => AppSpacing.sm;
  double get md => AppSpacing.md;
  double get lg => AppSpacing.lg;
  double get xl => AppSpacing.xl;
  double get xxl => AppSpacing.xxl;
  double get section => AppSpacing.section;
  double get sectionLarge => AppSpacing.sectionLarge;
  double get screenPadding => AppSpacing.screenPadding;
  double get cardGap => AppSpacing.cardGap;
}
