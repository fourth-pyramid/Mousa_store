import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';

class PurchaseTypeSelectionSheet extends StatelessWidget {
  const PurchaseTypeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<PriceModeCubit, PriceModeState>(
    builder: (context, state) {
      final currentMode = state.mode;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context,
            title: context.l10n.wholesale_text,
            value: PriceMode.wholesale,
            groupValue: currentMode,
            icon: Icons.storefront_outlined,
          ),
          _buildOption(
            context,
            title: context.l10n.retail_text,
            value: PriceMode.retail,
            groupValue: currentMode,
            icon: Icons.shopping_bag_outlined,
          ),
        ],
      );
    },
  );

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required PriceMode value,
    required PriceMode groupValue,
    required IconData icon,
  }) {
    final isSelected = value == groupValue;
    final activeColor = context.colors.textPrimary;
    final inactiveColor = context.colors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: isSelected ? context.colors.surfaceStrong : context.colors.transparent,
        borderRadius: context.radius.smBorder,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () {
            if (isSelected) {
              Navigator.pop(context);
              return;
            }

            _showConfirmationDialog(context, value);
          },
          leading: Icon(icon, color: isSelected ? activeColor : inactiveColor),
          title: Text(
            title,
            style: context.typography.bodyLarge.copyWith(
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: isSelected ? Icon(Icons.check_circle, color: activeColor) : null,
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, PriceMode newMode) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(context.l10n.change_purchase_type_confirmation_title),
          content: Text(context.l10n.change_purchase_type_confirmation_message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.l10n.cancel_text),
            ),
            TextButton(
              onPressed: () {
                context.read<PriceModeCubit>().setPriceMode(newMode);
                Navigator.pop(dialogContext); // Close dialog
                Navigator.pop(context); // Close bottom sheet
              },
              child: Text(context.l10n.confirm_text),
            ),
          ],
        ),
      ),
    );
  }
}
