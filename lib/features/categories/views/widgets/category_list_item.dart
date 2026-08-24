import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({required this.image, required this.title, required this.onTap, super.key});

  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: context.colors.surface, borderRadius: context.radius.lgBorder),
          child: Stack(
            children: [
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title.toUpperCase(),
                              style: context.typography.h3.copyWith(color: context.colors.textPrimary, letterSpacing: 0.5),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Text(
                                  context.l10n.explore_text,
                                  style: context.typography.caption.copyWith(
                                    color: context.colors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(Icons.arrow_forward_rounded, size: 14.w, color: context.colors.textSecondary),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AppImage(
                        image: image,
                        errorWidget: (_, _, _) => Center(
                          child: Icon(Icons.sports_soccer, size: 24.w, color: context.colors.textSecondary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
