import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/color_resolver.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/category_items/data/models/attribute_model.dart';

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
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 8,
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
        const SizedBox(height: 6),
        if (_isColor)
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: values.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
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
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
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

  @override
  Widget build(BuildContext context) {
    final colors = ColorResolver.resolveColors(attrValue.value);
    final primaryColor = colors.first;
    final isLightColor =
        ThemeData.estimateBrightnessForColor(primaryColor) == Brightness.light;

    final BoxDecoration swatchDecoration;
    if (colors.length == 1) {
      swatchDecoration = BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isLightColor ? context.colors.border : Colors.transparent,
        ),
      );
    } else {
      final gradientColors = <Color>[];
      final stops = <double>[];
      final step = 1.0 / colors.length;
      for (var i = 0; i < colors.length; i++) {
        gradientColors
          ..add(colors[i])
          ..add(colors[i]);
        stops
          ..add(i * step)
          ..add((i + 1) * step);
      }
      swatchDecoration = BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
          stops: stops,
        ),
        border: Border.all(color: context.colors.border),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: context.durations.fast,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.primary.withValues(alpha: 0.08)
                : context.colors.surfaceStrong.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? context.colors.primary
                  : context.colors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: swatchDecoration,
                child: isSelected
                    ? Center(
                        child: Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: isLightColor
                              ? const Color(0xFF111111)
                              : Colors.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
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
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: context.durations.fast,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.surfaceStrong.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
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
                size: 16,
                color: context.colors.onPrimary,
              ),
              const SizedBox(width: 6),
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
