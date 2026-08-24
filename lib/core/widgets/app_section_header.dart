import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.toUpperCase(),
                  style: context.typography.h3.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: context.typography.bodySmall.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  actionLabel!.toUpperCase(),
                  style: context.typography.labelLarge.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
}
