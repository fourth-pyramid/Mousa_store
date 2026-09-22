import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class NotificationTabs extends StatelessWidget {
  const NotificationTabs({
    required this.selectedIndex,
    required this.onChanged,
    this.allCount = 0,
    this.ordersCount = 0,
    this.offersCount = 0,
    this.alertsCount = 0,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final int allCount;
  final int ordersCount;
  final int offersCount;
  final int alertsCount;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(16.w),
    child: Row(
      children: [
        _NotificationTabButton(
          title: context.l10n.all_tab_text,
          count: allCount,
          index: 0,
          isSelected: selectedIndex == 0,
          onTap: () => onChanged(0),
        ),
        SizedBox(width: 8.w),
        _NotificationTabButton(
          title: context.l10n.orders_text,
          count: ordersCount,
          index: 1,
          isSelected: selectedIndex == 1,
          onTap: () => onChanged(1),
        ),
        SizedBox(width: 8.w),
        _NotificationTabButton(
          title: context.l10n.offers_tab_text,
          count: offersCount,
          index: 2,
          isSelected: selectedIndex == 2,
          onTap: () => onChanged(2),
        ),
        SizedBox(width: 8.w),
        _NotificationTabButton(
          title: context.l10n.alerts_tab_text,
          count: alertsCount,
          index: 3,
          isSelected: selectedIndex == 3,
          onTap: () => onChanged(3),
        ),
      ],
    ),
  );
}

class _NotificationTabButton extends StatelessWidget {
  const _NotificationTabButton({
    required this.title,
    required this.count,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final int count;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final displayText = count > 0 ? '$title ($count)' : title;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary : context.colors.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: !isSelected
                ? Border.all(color: context.colors.border)
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: Text(
                displayText,
                style: context.typography.labelMedium.copyWith(
                  color: isSelected
                      ? context.colors.onPrimary
                      : context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
