import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/viewmodels/home_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBannerSliderSection extends StatefulWidget {
  const HomeBannerSliderSection({super.key});

  @override
  State<HomeBannerSliderSection> createState() =>
      _HomeBannerSliderSectionState();
}

class _HomeBannerSliderSectionState extends State<HomeBannerSliderSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.bannerStatus != current.bannerStatus ||
            previous.banners != current.banners,
        builder: (context, state) {
          if (state.bannerStatus == RequestStatus.loading) {
            return Padding(
              padding: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
              child: Container(
                height: 195.h,
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
            final banners = state.banners;
            return Column(
              children: [
                SizedBox(height: 12.h),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 195.h,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 600),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    viewportFraction: 0.88,
                    onPageChanged: (index, _) {
                      setState(() => _currentIndex = index);
                    },
                  ),
                  items: banners.map((banner) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: context.radius.lgBorder,
                      boxShadow: AppShadows.card,
                    ),
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
                                color: context.colors.surfaceStrong,
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 48.w,
                                  color: context.colors.textSecondary,
                                ),
                              ),
                            ),
                            // Multi-stop scrim for text readability
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.15),
                                    Colors.black.withValues(alpha: 0.82),
                                  ],
                                  stops: const [0.0, 0.45, 1.0],
                                ),
                              ),
                            ),
                            // Accent left bar for brand identity
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3.w,
                                color:
                                    AppColorTokens.accent.withValues(alpha: 0.9),
                              ),
                            ),
                            // Text content
                            Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    banner.title,
                                    style: context.typography.h2.copyWith(
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                      height: 1.15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 2,
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
                  ).toList(),
                ),
                SizedBox(height: 12.h),
                // WormEffect indicator
                AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: banners.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 5.h,
                    dotWidth: 5.w,
                    expansionFactor: 4,
                    spacing: 4.w,
                    activeDotColor: AppColorTokens.accent,
                    dotColor: AppColorTokens.accent.withValues(alpha: 0.25),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      );
}
