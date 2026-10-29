import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/features/category_items/presentation/widgets/filter_widget.dart';
import 'package:mousa_store/features/category_items/presentation/widgets/sort_widget.dart';
import 'package:mousa_store/features/search/presentation/widgets/search_text_field.dart';

class SearchAndFilters extends StatelessWidget {
  const SearchAndFilters({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Search Field
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
        child: Material(
          elevation: 3,
          borderRadius: context.radius.mdBorder,
          shadowColor: context.colors.textPrimary.withAlpha(
            (0.2 * 255).toInt(),
          ),
          child: const SearchTextField(),
        ),
      ),

      // Filters & Sort Row
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            const FilterWidget(),
            Container(
              width: 1,
              height: 28,
              color: context.colors.border,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
            ),
            const SortWidget(),
          ],
        ),
      ),
    ],
  );
}
