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
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        _buildTab(context: context, title: context.l10n.all_tab_text, count: allCount, index: 0),
        const SizedBox(width: 8),
        _buildTab(context: context, title: context.l10n.orders_text, count: ordersCount, index: 1),
        const SizedBox(width: 8),
        _buildTab(context: context, title: context.l10n.offers_tab_text, count: offersCount, index: 2),
        const SizedBox(width: 8),
        _buildTab(context: context, title: context.l10n.alerts_tab_text, count: alertsCount, index: 3),
      ],
    ),
  );

  Widget _buildTab({required String title, required BuildContext context, required int count, required int index}) {
    final isSelected = selectedIndex == index;
    final displayText = count > 0 ? '$title ($count)' : title;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary : context.colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: !isSelected ? Border.all(color: context.colors.border) : null,
          ),
          child: Text(
            displayText,
            style: context.typography.labelMedium.copyWith(
              color: isSelected ? context.colors.onPrimary : context.colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
