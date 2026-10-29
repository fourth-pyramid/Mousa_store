import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';

class FilterBottomActions extends StatelessWidget {
  const FilterBottomActions({
    required this.activeFilterCount,
    required this.onApply,
    required this.onReset,
    super.key,
  });

  final int activeFilterCount;
  final VoidCallback onApply;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.colors.surface,
      border: Border(top: BorderSide(color: context.colors.border)),
      boxShadow: [
        BoxShadow(
          color: context.colors.textPrimary.withValues(alpha: 0.04),
          offset: const Offset(0, -4),
          blurRadius: 12,
        ),
      ],
    ),
    padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
    child: SafeArea(
      top: false,
      child: Row(
        children: [
          // Reset action button
          OutlinedButton(
            onPressed: activeFilterCount > 0 ? onReset : null,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(100, 48),
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
              side: BorderSide(
                color: activeFilterCount > 0
                    ? context.colors.border
                    : context.colors.border.withValues(alpha: 0.4),
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh_rounded,
                  size: 18,
                  color: activeFilterCount > 0
                      ? context.colors.textPrimary
                      : context.colors.textMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  context.l10n.clear_all_text,
                  style: context.typography.bodySmall.copyWith(
                    color: activeFilterCount > 0
                        ? context.colors.textPrimary
                        : context.colors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Apply button
          Expanded(
            child: CustomButton(
              height: 48,
              text: Text(
                activeFilterCount > 0
                    ? '${context.l10n.apply_text} ($activeFilterCount)'
                    : context.l10n.apply_text,
              ),
              onPressed: onApply,
            ),
          ),
        ],
      ),
    ),
  );
}
