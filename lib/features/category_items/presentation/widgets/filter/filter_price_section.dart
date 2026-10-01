import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class FilterPriceSection extends StatelessWidget {
  const FilterPriceSection({
    required this.priceRange,
    required this.minPossible,
    required this.maxPossible,
    required this.onPriceChanged,
    super.key,
  });

  final RangeValues priceRange;
  final double minPossible;
  final double maxPossible;
  final ValueChanged<RangeValues> onPriceChanged;

  @override
  Widget build(BuildContext context) {
    final effectiveMin = minPossible;
    final effectiveMax = maxPossible > minPossible
        ? maxPossible
        : minPossible + 1000;

    final currentStart = priceRange.start.clamp(effectiveMin, effectiveMax);
    final currentEnd = priceRange.end.clamp(effectiveMin, effectiveMax);
    final safeRange = RangeValues(
      currentStart <= currentEnd ? currentStart : effectiveMin,
      currentEnd >= currentStart ? currentEnd : effectiveMax,
    );

    final rangeSpan = effectiveMax - effectiveMin;
    final divisions = rangeSpan > 0 ? rangeSpan.toInt().clamp(1, 100) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: Text(
            context.l10n.prices_text,
            style: context.typography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 6.h),

        // Dual Min/Max Price Display Cards
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: _PriceValueCard(
                  label: context.l10n.min_price_text,
                  amount: safeRange.start.toInt(),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                child: Container(
                  width: 14.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: context.colors.textMuted,
                    borderRadius: context.radius.pillBorder,
                  ),
                ),
              ),
              Expanded(
                child: _PriceValueCard(
                  label: context.l10n.max_price_text,
                  amount: safeRange.end.toInt(),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Themed Range Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: context.colors.primary,
            inactiveTrackColor: context.colors.surfaceStrong,
            thumbColor: context.colors.primary,
            overlayColor: context.colors.primary.withValues(alpha: 0.12),
            trackHeight: 4.h,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 9,
              elevation: 3,
            ),
          ),
          child: RangeSlider(
            values: safeRange,
            min: effectiveMin,
            max: effectiveMax,
            divisions: divisions,
            onChanged: onPriceChanged,
          ),
        ),

        // Quick Price Presets
        if (rangeSpan > 100) ...[
          SizedBox(height: 4.h),
          _PricePresetsRow(
            minPossible: effectiveMin,
            maxPossible: effectiveMax,
            currentRange: safeRange,
            onPresetSelected: onPriceChanged,
          ),
        ],
      ],
    );
  }
}

class _PriceValueCard extends StatelessWidget {
  const _PriceValueCard({required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: context.colors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.caption.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Text(
              '$amount',
              style: context.typography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              context.l10n.egp_text,
              style: context.typography.caption.copyWith(
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _PricePresetsRow extends StatelessWidget {
  const _PricePresetsRow({
    required this.minPossible,
    required this.maxPossible,
    required this.currentRange,
    required this.onPresetSelected,
  });

  final double minPossible;
  final double maxPossible;
  final RangeValues currentRange;
  final ValueChanged<RangeValues> onPresetSelected;

  @override
  Widget build(BuildContext context) {
    final span = maxPossible - minPossible;
    final quarter = minPossible + (span * 0.25);
    final half = minPossible + (span * 0.5);

    final presets = <({String title, RangeValues range})>[
      (
        title: '< ${quarter.toInt()}',
        range: RangeValues(minPossible, quarter.roundToDouble()),
      ),
      (
        title: '${quarter.toInt()} - ${half.toInt()}',
        range: RangeValues(quarter.roundToDouble(), half.roundToDouble()),
      ),
      (
        title: '> ${half.toInt()}',
        range: RangeValues(half.roundToDouble(), maxPossible),
      ),
    ];

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      child: Row(
        children: presets.map((preset) {
          final isSelected =
              (currentRange.start - preset.range.start).abs() < 5 &&
              (currentRange.end - preset.range.end).abs() < 5;

          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 3.w),
              child: InkWell(
                onTap: () => onPresetSelected(preset.range),
                borderRadius: BorderRadius.circular(8.r),
                child: AnimatedContainer(
                  duration: context.durations.fast,
                  padding: EdgeInsetsDirectional.symmetric(vertical: 6.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.primary.withValues(alpha: 0.1)
                        : context.colors.surfaceStrong.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? context.colors.primary
                          : context.colors.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    preset.title,
                    style: context.typography.caption.copyWith(
                      color: isSelected
                          ? context.colors.primary
                          : context.colors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
