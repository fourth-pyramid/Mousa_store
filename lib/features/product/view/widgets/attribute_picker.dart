import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AttributePicker extends StatelessWidget {
  const AttributePicker({
    required this.values,
    required this.selectedValue,
    required this.onValueSelected,
    this.availableValues = const [],
    super.key,
  });

  final List<String> values;
  final List<String> availableValues;
  final String? selectedValue;
  final ValueChanged<String> onValueSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: values.length,
      separatorBuilder: (context, index) => SizedBox(width: 12.w),
      itemBuilder: (context, index) {
        final value = values[index];
        final isSelected = selectedValue == value;
        final isAvailable = availableValues.contains(value);
        final displayName = value;

        return GestureDetector(
          onTap: isAvailable ? () => onValueSelected(value) : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colors.primary
                  : context.colors.transparent,
              borderRadius: context.radius.smBorder,
              border: Border.all(
                color: isSelected
                    ? context.colors.primary
                    : (isAvailable
                          ? context.colors.border
                          : context.colors.surface),
                width: 0.5.w,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    displayName,
                    style: context.typography.body.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? context.colors.onPrimary
                          : (isAvailable
                                ? context.colors.textPrimary
                                : context.colors.textSecondary),
                    ),
                  ),
                  if (!isAvailable)
                    Transform.rotate(
                      angle: -0.5,
                      child: Container(
                        width: 30.w,
                        height: 1.5.h,
                        color: context.colors.border,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
