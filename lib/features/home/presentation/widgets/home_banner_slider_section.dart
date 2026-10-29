import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_carousel_slider.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/app_page_indicator.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_state.dart';

class HomeBannerSliderSection extends StatefulWidget {
  const HomeBannerSliderSection({super.key});

  @override
  State<HomeBannerSliderSection> createState() =>
      _HomeBannerSliderSectionState();
}

class _HomeBannerSliderSectionState extends State<HomeBannerSliderSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
    buildWhen: (previous, current) =>
        previous.bannerStatus != current.bannerStatus ||
        previous.banners != current.banners,
    builder: (context, state) {
      if (state.bannerStatus == RequestStatus.loading) {
        return Padding(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
          child: Container(
            height: 195,
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
            const SizedBox(height: 12),
            AppCarouselSlider.items(
              height: 195,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.88,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              items: banners
                  .map(
                    (banner) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
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
                                  size: 48,
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
                                width: 3,
                                color: AppColorTokens.accent.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                            ),
                            // Text content
                            Padding(
                              padding: const EdgeInsets.all(16),
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
                                    const SizedBox(height: 4),
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
            const SizedBox(height: 12),
            AppExpandingDotsIndicator(
              activeIndex: _currentIndex,
              count: banners.length,
              effect: ExpandingDotsConfig(
                dotHeight: 5,
                dotWidth: 5,
                spacing: 4,
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
