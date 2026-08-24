import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppQuantitySelector extends StatelessWidget {
  const AppQuantitySelector({
    required this.quantity,
    required this.onChanged,
    super.key,
    this.min = 1,
    this.max = 99,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: context.radius.smBorder,
        border: Border.all(
          color: context.colors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, size: 16),
            onPressed: quantity > min ? () => onChanged(quantity - 1) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              quantity.toString(),
              style: context.typography.body.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, size: 16),
            onPressed: quantity < max ? () => onChanged(quantity + 1) : null,
          ),
        ],
      ),
    );
}
