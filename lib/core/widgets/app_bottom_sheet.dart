import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.child,
    super.key,
    this.title,
    this.showDragHandle = true,
  });

  final String? title;
  final Widget child;
  final bool showDragHandle;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
  }) => showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: context.colors.transparent,
    builder: (ctx) => AppBottomSheet(title: title, child: child),
  );

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface,
    borderRadius: context.radius.bottomSheet,
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDragHandle)
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceStrong,
                    borderRadius: context.radius.pillBorder,
                  ),
                ),
              ),
            if (title != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title!.toUpperCase(), style: context.typography.h3),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: context.colors.textSecondary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: 12.h),
            ],
            Flexible(child: child),
          ],
        ),
      ),
    ),
  );
}
