import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';

class HomeBannerSliderSection extends StatelessWidget {
  const HomeBannerSliderSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        previous.bannerStatus != current.bannerStatus ||
        previous.banners != current.banners,
    builder: (context, state) {
      if (state.bannerStatus == RequestStatus.loading) {
        return Padding(
          padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
          child: Container(
            height: 165.h,
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: context.radius.lgBorder,
            ),
          ),
        );
      }

      if (state.bannerStatus == RequestStatus.failure) {
        return const SizedBox.shrink();
      }

      if (state.bannerStatus == RequestStatus.success &&
          state.banners.isNotEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 170.h,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              viewportFraction: 0.89,
            ),
            items: state.banners
                .map(
                  (banner) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    child: ClipRRect(
                      borderRadius: context.radius.lgBorder,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppImage(
                            image: banner.imagePath,
                            placeholder: (_, _) =>
                                ColoredBox(color: context.colors.surface),
                            errorWidget: (_, _, _) => ColoredBox(
                              color: context.colors.surface,
                              child: Icon(
                                Icons.sports_soccer,
                                size: 48.w,
                                color: context.colors.textSecondary,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  context.colors.transparent,
                                  context.colors.primary.withValues(
                                    alpha: 0.75,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(14.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  banner.title.toUpperCase(),
                                  style: context.typography.h2.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    height: 1.1,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (banner.desc.isNotEmpty) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    banner.desc,
                                    style: context.typography.bodySmall
                                        .copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.85,
                                          ),
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      }

      return const SizedBox.shrink();
    },
  );
}
