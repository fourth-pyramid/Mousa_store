import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/app_sizes.dart';

extension AppSizesContextExtension on BuildContext {
  /// Accessor for size tokens via context
  AppSizesTokens get sizes => const AppSizesTokens();
}

class AppSizesTokens {
  const AppSizesTokens();

  double get buttonHeight => AppSizes.buttonHeight;
  double get inputHeight => AppSizes.inputHeight;
  double get searchBarHeight => AppSizes.searchBarHeight;
  double get minTouchTarget => AppSizes.minTouchTarget;
  double get iconSm => AppSizes.iconSm;
  double get iconMd => AppSizes.iconMd;
  double get iconLg => AppSizes.iconLg;
  double get iconXl => AppSizes.iconXl;
  double get navBarHeight => AppSizes.navBarHeight;
  double get navIconSize => AppSizes.navIconSize;
}
