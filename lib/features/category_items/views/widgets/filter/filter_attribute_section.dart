import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/category_items/models/attribute_model.dart';

class FilterAttributeSection extends StatelessWidget {
  const FilterAttributeSection({
    required this.title,
    required this.values,
    required this.selectedIds,
    required this.onChanged,
    super.key,
  });

  final String title;
  final List<AttributeValue> values;
  final Set<int> selectedIds;
  final ValueChanged<Set<int>> onChanged;

  bool get _isColor {
    final lower = title.toLowerCase();
    return lower.contains('color') || lower.contains('لون');
  }

  void _toggleSelection(int id) {
    final newSet = Set<int>.from(selectedIds);
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    onChanged(newSet);
  }

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: context.typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (selectedIds.isNotEmpty) ...[
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
                      '${selectedIds.length}',
                      style: context.typography.caption.copyWith(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 6.h),
        if (_isColor)
          SizedBox(
            height: 52.h,
            child: ListView.separated(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: values.length,
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (context, index) {
                final attrValue = values[index];
                final isSelected = selectedIds.contains(attrValue.id);
                return _ColorSwatchChip(
                  attrValue: attrValue,
                  isSelected: isSelected,
                  onTap: () => _toggleSelection(attrValue.id),
                );
              },
            ),
          )
        else
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: values.map((attrValue) {
                final isSelected = selectedIds.contains(attrValue.id);
                return _StandardFilterChip(
                  attrValue: attrValue,
                  isSelected: isSelected,
                  onTap: () => _toggleSelection(attrValue.id),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _ColorSwatchChip extends StatelessWidget {
  const _ColorSwatchChip({
    required this.attrValue,
    required this.isSelected,
    required this.onTap,
  });

  final AttributeValue attrValue;
  final bool isSelected;
  final VoidCallback onTap;

  Color _resolveColor(String value) {
    final clean = value.trim().toLowerCase();
    if (clean.startsWith('#')) {
      final hex = clean.replaceFirst('#', '');
      if (hex.length == 6) {
        final parsed = int.tryParse('FF$hex', radix: 16);
        if (parsed != null) return Color(parsed);
      } else if (hex.length == 8) {
        final parsed = int.tryParse(hex, radix: 16);
        if (parsed != null) return Color(parsed);
      }
    }

    switch (clean) {
      case 'black':
      case 'أسود':
      case 'اسود':
        return const Color(0xFF18181B);
      case 'white':
      case 'أبيض':
      case 'ابيض':
        return const Color(0xFFFFFFFF);
      case 'red':
      case 'أحمر':
      case 'احمر':
        return const Color(0xFFEF4444);
      case 'blue':
      case 'أزرق':
      case 'ازرق':
        return const Color(0xFF3B82F6);
      case 'green':
      case 'أخضر':
      case 'اخضر':
        return const Color(0xFF10B981);
      case 'yellow':
      case 'أصفر':
      case 'اصفر':
        return const Color(0xFFF59E0B);
      case 'orange':
      case 'برتقالي':
        return const Color(0xFFF97316);
      case 'purple':
      case 'بنفسجي':
        return const Color(0xFF8B5CF6);
      case 'pink':
      case 'وردي':
      case 'بمبي':
        return const Color(0xFFEC4899);
      case 'grey':
      case 'gray':
      case 'رمادي':
        return const Color(0xFF6B7280);
      case 'brown':
      case 'بني':
        return const Color(0xFF78350F);
      case 'navy':
      case 'كحلي':
        return const Color(0xFF1E3A8A);
      case 'beige':
      case 'بيج':
        return const Color(0xFFD4C5B9);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(attrValue.value);
    final isLightColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: context.durations.fast,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 10.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.primary.withValues(alpha: 0.08)
                : context.colors.surfaceStrong.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? context.colors.primary : context.colors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20.r,
                height: 20.r,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isLightColor
                        ? context.colors.border
                        : Colors.transparent,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Icon(
                          Icons.check_rounded,
                          size: 12.r,
                          color: isLightColor
                              ? const Color(0xFF111111)
                              : Colors.white,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 8.w),
              Text(
                attrValue.value,
                style: context.typography.bodySmall.copyWith(
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StandardFilterChip extends StatelessWidget {
  const _StandardFilterChip({
    required this.attrValue,
    required this.isSelected,
    required this.onTap,
  });

  final AttributeValue attrValue;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: context.durations.fast,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.surfaceStrong.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Icon(
                Icons.check_rounded,
                size: 16.r,
                color: context.colors.onPrimary,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              attrValue.value,
              style: context.typography.bodySmall.copyWith(
                color: isSelected
                    ? context.colors.onPrimary
                    : context.colors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
