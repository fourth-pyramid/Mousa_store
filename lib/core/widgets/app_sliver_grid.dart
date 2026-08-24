import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSliverGrid<T> extends StatelessWidget {
  const AppSliverGrid({
    required this.items,
    required this.itemBuilder,
    required this.isLoading,
    this.isError = false,
    this.errorMessage,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 0.74, // ponytail: ratio 0.74 fits product card tightly without overflow
    this.emptyWidget,
    this.loadingItemCount = 6,
    this.loadingBuilder,
    super.key,
  });

  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final Widget? emptyWidget;
  final int loadingItemCount;
  final Widget Function(BuildContext, int)? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer.sliver(
        child: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing.h,
            crossAxisSpacing: crossAxisSpacing.w,
            childAspectRatio: childAspectRatio,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => loadingBuilder != null
                ? loadingBuilder!(context, index)
                : Card(child: ListTile(title: Text(context.l10n.loading_text, style: context.typography.body))),
            childCount: loadingItemCount,
          ),
        ),
      );
    }

    if (isError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(errorMessage ?? context.l10n.error_occurred_text, style: context.typography.body)),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: emptyWidget ?? Center(child: Text(context.l10n.empty_category_items_title, style: context.typography.body)),
      );
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing.h,
        crossAxisSpacing: crossAxisSpacing.w,
        childAspectRatio: childAspectRatio,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => itemBuilder(context, items[index], index),
        childCount: items.length,
      ),
    );
  }
}
