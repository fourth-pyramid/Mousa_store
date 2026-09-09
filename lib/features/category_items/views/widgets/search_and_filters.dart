import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/features/category_items/views/widgets/filter_widget.dart';
import 'package:mousa_store/features/category_items/views/widgets/sort_widget.dart';
import 'package:mousa_store/features/search/view/widgets/search_text_field.dart';

class SearchAndFilters extends StatelessWidget {
  const SearchAndFilters({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Search Field
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 0),
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
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Row(
          children: [
            const FilterWidget(),
            Container(
              width: 1,
              height: 28.h,
              color: context.colors.border,
              margin: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
            ),
            const SortWidget(),
          ],
        ),
      ),
    ],
  );
}
