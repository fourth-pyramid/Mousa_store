import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';

class HomeServicesBannerSection extends StatelessWidget {
  const HomeServicesBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bannerImage = isDark
        ? context.l10n.services_banner_image_dark
        : context.l10n.services_banner_image_light;

    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.border.withValues(alpha: 0.6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: AppImage(image: bannerImage),
        ),
      ),
    );
  }
}
