import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

enum AppBadgeVariant { neutral, accent, success, outline }

class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    super.key,
    this.variant = AppBadgeVariant.neutral,
  });

  final String label;
  final AppBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (variant) {
      case AppBadgeVariant.neutral:
        bg = context.colors.surfaceStrong;
        fg = context.colors.textPrimary;
        break;
      case AppBadgeVariant.accent:
        bg = context.colors.accent;
        fg = context.colors.onSecondary;
        break;
      case AppBadgeVariant.success:
        bg = context.colors.success;
        fg = context.colors.onPrimary;
        break;
      case AppBadgeVariant.outline:
        bg = context.colors.transparent;
        fg = context.colors.textPrimary;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: context.radius.xsBorder,
        border: variant == AppBadgeVariant.outline
            ? Border.all(color: context.colors.border)
            : null,
      ),
      child: Text(
        label.toUpperCase(),
        style: context.typography.caption.copyWith(
          color: fg,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
