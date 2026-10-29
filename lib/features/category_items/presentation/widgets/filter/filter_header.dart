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
          width: 44,
          height: 4,
          margin: const EdgeInsets.only(top: 10, bottom: 12),
          decoration: BoxDecoration(
            color: context.colors.surfaceStrong,
            borderRadius: context.radius.pillBorder,
          ),
        ),
      ),

      // Title & Actions Bar
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              context.l10n.filter_text,
              style: context.typography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (activeFilterCount > 0) ...[
              const SizedBox(width: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: context.radius.pillBorder,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 8,
                    vertical: 2,
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
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                minimumSize: const Size(44, 44),
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
            const SizedBox(width: 4),
            // Close button
            Material(
              color: context.colors.surfaceStrong.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onClose,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Divider(height: 1, color: context.colors.divider),
    ],
  );
}
