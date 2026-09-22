import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    super.key,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.badge,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? icon;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final bg = isSelected ? context.colors.primary : context.colors.surface;
    final fg = isSelected
        ? context.colors.onPrimary
        : context.colors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: context.durations.fast,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: context.radius.pillBorder,
          border: Border.all(color: isSelected ? bg : context.colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 6.w)],
            Text(
              label,
              style: context.typography.labelMedium.copyWith(color: fg),
            ),
            if (badge != null) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? fg.withValues(alpha: 0.2)
                      : context.colors.secondary,
                  borderRadius: context.radius.pillBorder,
                ),
                child: Text(
                  badge!,
                  style: context.typography.caption.copyWith(
                    color: isSelected ? fg : context.colors.onSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
