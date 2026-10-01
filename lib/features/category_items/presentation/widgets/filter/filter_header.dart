import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({
    required this.activeFilterCount,
    required this.onClearAll,
    required this.onClose,
    super.key,
  });

  final int activeFilterCount;
  final VoidCallback onClearAll;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Drag Handle
      Center(
        child: Container(
          width: 44.w,
          height: 4.h,
          margin: EdgeInsets.only(top: 10.h, bottom: 12.h),
          decoration: BoxDecoration(
            color: context.colors.surfaceStrong,
            borderRadius: context.radius.pillBorder,
          ),
        ),
      ),

      // Title & Actions Bar
      Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Text(
              context.l10n.filter_text,
              style: context.typography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (activeFilterCount > 0) ...[
              SizedBox(width: 8.w),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: context.radius.pillBorder,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8.w,
                    vertical: 2.h,
                  ),
                  child: Text(
                    '$activeFilterCount',
                    style: context.typography.caption.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            const Spacer(),
            // Clear all button
            TextButton(
              onPressed: activeFilterCount > 0 ? onClearAll : null,
              style: TextButton.styleFrom(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                minimumSize: Size(44.w, 44.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                context.l10n.clear_all_text,
                style: context.typography.bodySmall.copyWith(
                  color: activeFilterCount > 0
                      ? context.colors.accent
                      : context.colors.textMuted,
                  fontWeight: activeFilterCount > 0
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            // Close button
            Material(
              color: context.colors.surfaceStrong.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: onClose,
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20.r,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12.h),
      Divider(height: 1.h, color: context.colors.divider),
    ],
  );
}
