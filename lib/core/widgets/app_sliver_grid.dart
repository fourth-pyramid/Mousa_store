import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_skeleton.dart';

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
    this.childAspectRatio = 0.70,
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
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    final effectiveAspectRatio = childAspectRatio / textScale.clamp(1.0, 1.45);

    if (isLoading) {
      return SliverLayoutBuilder(
        builder: (context, constraints) {
          final columns = AppScreenUtils.adaptiveGridColumns(
            constraints.crossAxisExtent,
            phoneColumns: crossAxisCount,
            tabletColumns: crossAxisCount + 1,
            expandedColumns: crossAxisCount + 2,
          );
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: effectiveAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => loadingBuilder != null
                  ? loadingBuilder!(context, index)
                  : const AppSkeletonCard(),
              childCount: loadingItemCount,
            ),
          );
        },
      );
    }

    if (isError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            errorMessage ?? context.l10n.error_occurred_text,
            style: context.typography.body,
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child:
            emptyWidget ??
            Center(
              child: Text(
                context.l10n.empty_category_items_title,
                style: context.typography.body,
              ),
            ),
      );
    }

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final columns = AppScreenUtils.adaptiveGridColumns(
          constraints.crossAxisExtent,
          phoneColumns: crossAxisCount,
          tabletColumns: crossAxisCount + 1,
          expandedColumns: crossAxisCount + 2,
        );
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: effectiveAspectRatio,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => itemBuilder(context, items[index], index),
            childCount: items.length,
          ),
        );
      },
    );
  }
}
