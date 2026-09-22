import 'package:flutter/material.dart';
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
      children: [
        Expanded(
          child: Row(
            children: [
              // Accent left bar
              Container(
                width: 3.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: context.colors.accent,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: context.typography.h3.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 1.h),
                      Text(
                        subtitle!,
                        style: context.typography.caption.copyWith(
                          color: context.colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (actionLabel != null && onActionTap != null)
          GestureDetector(
            onTap: onActionTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionLabel!,
                    style: context.typography.label.copyWith(
                      color: context.colors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10.r,
                    color: context.colors.accent,
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
