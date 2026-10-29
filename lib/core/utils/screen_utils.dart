import 'package:flutter/widgets.dart';

/// Centralized responsive breakpoints for the Mousa Store design system.
///
/// Breakpoints represent layout capability, not specific device models:
/// - `< 360`: Compact phones
/// - `360 ..< 600`: Standard & large phones
/// - `600 ..< 840`: Small tablets / foldables
/// - `>= 840`: Large tablets / expanded layouts
abstract final class AppBreakpoints {
  /// Compact phone upper threshold (`360px`).
  static const double compactPhoneMaxWidth = 360;

  /// Standard/large phone upper threshold (`600px`).
  static const double phoneMaxWidth = 600;

  /// Tablet upper threshold (`840px`).
  static const double tabletMaxWidth = 840;

  /// Maximum readable width for forms, dialogs, and narrow content (`520px`).
  static const double maxFormWidth = 520;

  /// Maximum width for bottom sheets and medium containers (`640px`).
  static const double maxSheetWidth = 640;

  /// Maximum content width for centered single-column views on large screens (`840px`).
  static const double maxContentWidth = 840;
}

/// Native Flutter responsive utilities replacing `flutter_screenutil`.
abstract final class AppScreenUtils {
  /// Returns `true` when viewport width is `< 360`.
  static bool isCompactPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppBreakpoints.compactPhoneMaxWidth;

  /// Returns `true` when viewport width is `< 600`.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppBreakpoints.phoneMaxWidth;

  /// Returns `true` when viewport width is `>= 600` and `< 840`.
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppBreakpoints.phoneMaxWidth &&
        width < AppBreakpoints.tabletMaxWidth;
  }

  /// Returns `true` when viewport width is `>= 840`.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppBreakpoints.tabletMaxWidth;

  /// Computes an adaptive grid column count from available `maxWidth`.
  static int adaptiveGridColumns(
    double maxWidth, {
    int phoneColumns = 2,
    int tabletColumns = 3,
    int expandedColumns = 4,
  }) {
    if (maxWidth >= AppBreakpoints.tabletMaxWidth) return expandedColumns;
    if (maxWidth >= AppBreakpoints.phoneMaxWidth) return tabletColumns;
    return phoneColumns;
  }
}

/// Constrains child content to [maxWidth] while centering it in available space.
class ResponsiveConstrainedBox extends StatelessWidget {
  const ResponsiveConstrainedBox({
    required this.child,
    super.key,
    this.maxWidth = AppBreakpoints.maxContentWidth,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) => Align(
    alignment: alignment,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
