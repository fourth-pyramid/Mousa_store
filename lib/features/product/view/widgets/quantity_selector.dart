import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    required this.selectedQuantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    this.maxQuantity,
    super.key,
  });

  final int selectedQuantity;
  final int minQuantity;
  final int? maxQuantity;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final limit = maxQuantity ?? (minQuantity + 10);
    final effectiveLimit = limit < minQuantity ? minQuantity : limit;

    final displayLimit = (effectiveLimit - minQuantity + 1) > 50
        ? minQuantity + 49
        : effectiveLimit;

    final quantities = List<int>.generate(
      displayLimit - minQuantity + 1,
      (index) => minQuantity + index,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            context.l10n.quantity_text,
            style: context.typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 44.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: quantities.length,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final quantity = quantities[index];
              final isSelected = quantity == selectedQuantity;

              return GestureDetector(
                onTap: () => onQuantityChanged(quantity),
                child: Container(
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.surface,
                    borderRadius: context.radius.smBorder,
                    border: Border.all(
                      color: isSelected
                          ? context.colors.primary
                          : context.colors.border,
                      width: 0.5.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$quantity',
                      style: context.typography.body.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? context.colors.onPrimary : context.colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
