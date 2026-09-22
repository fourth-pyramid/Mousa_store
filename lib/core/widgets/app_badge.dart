import 'package:flutter/material.dart';
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
    Border? customBorder;

    switch (variant) {
      case AppBadgeVariant.neutral:
        bg = context.colors.surfaceStrong;
        fg = context.colors.textPrimary;
        break;
      case AppBadgeVariant.accent:
        bg = context.colors.accent;
        fg = Colors.white;
        break;
      case AppBadgeVariant.success:
        bg = context.colors.success.withValues(alpha: 0.15);
        fg = context.colors.success;
        break;
      case AppBadgeVariant.outline:
        bg = context.colors.transparent;
        fg = context.colors.textPrimary;
        customBorder = Border.all(color: context.colors.border);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: context.radius.chipBorder,
        border: customBorder,
        boxShadow: variant == AppBadgeVariant.accent ? AppShadows.subtle : null,
      ),
      child: Text(
        label.toUpperCase(),
        style: context.typography.caption.copyWith(
          color: fg,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
          height: 1.2,
        ),
      ),
    );
  }
}
