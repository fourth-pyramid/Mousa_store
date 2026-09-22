import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/product/view/widgets/product_image_viewer.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    required this.images,
    this.discountPercentage,
    super.key,
  });

  final List<String> images;
  final int? discountPercentage;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final ValueNotifier<int> _currentImageIndexNotifier = ValueNotifier<int>(0);
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void dispose() {
    _currentImageIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 300.h,
        color: context.colors.surfaceStrong,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48.r,
            color: context.colors.textMuted,
          ),
        ),
      );
    }

    final textDirection = Directionality.of(context);

    return Column(
      children: [
        // ── Edge-to-Edge Hero ──────────────────────────────────────
        SizedBox(
          height: 300.h,
          child: Stack(
            children: [
              // Carousel
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 300.h,
                  viewportFraction: 1,
                  enableInfiniteScroll: widget.images.length > 1,
                  onPageChanged: (index, reason) {
                    _currentImageIndexNotifier.value = index;
                  },
                ),
                items: widget.images.asMap().entries.map((entry) {
                  final index = entry.key;
                  final imageUrl = entry.value;

                  return GestureDetector(
                    onTap: () {
                      unawaited(
                        ProductImageViewer.open(
                          context,
                          images: widget.images,
                          initialIndex: index,
                        ),
                      );
                    },
                    child: ColoredBox(
                      color: context.colors.surface,
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Center(
                          child: Hero(
                            tag: 'product_image_${imageUrl}_$index',
                            child: AppImage(
                              image: imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                Icons.image_not_supported_outlined,
                                color: context.colors.textMuted,
                                size: 48.r,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Bottom gradient fade
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.18),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Discount Badge ───────────────────────────────────
              if (widget.discountPercentage != null &&
                  widget.discountPercentage! > 0)
                Positioned.directional(
                  textDirection: textDirection,
                  top: 14.h,
                  start: 14.w,
                  child: _DiscountBadge(
                    percentage: widget.discountPercentage!,
                  ),
                ),

              // ── Zoom hint ────────────────────────────────────────
              Positioned.directional(
                textDirection: textDirection,
                bottom: 12.h,
                start: 14.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.zoom_in_rounded,
                        size: 13.r,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'تكبير',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Dot Indicators ───────────────────────────────────
              if (widget.images.length > 1)
                Positioned(
                  bottom: 12.h,
                  left: 0,
                  right: 0,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentImageIndexNotifier,
                    builder: (context, currentIndex, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.images.length, (i) {
                        final isActive = i == currentIndex;
                        return AnimatedContainer(
                          duration: context.durations.fast,
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: isActive ? 18.w : 6.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // ── Thumbnails ────────────────────────────────────────────
        if (widget.images.length > 1) ...[
          SizedBox(height: 14.h),
          ValueListenableBuilder<int>(
            valueListenable: _currentImageIndexNotifier,
            builder: (context, currentImageIndex, _) => SizedBox(
              height: 68.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: widget.images.length,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  final isSelected = currentImageIndex == index;

                  return GestureDetector(
                    onTap: () {
                      unawaited(_carouselController.animateToPage(index));
                      _currentImageIndexNotifier.value = index;
                    },
                    child: AnimatedContainer(
                      duration: context.durations.fast,
                      width: 64.w,
                      height: 64.h,
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: context.radius.smBorder,
                        border: Border.all(
                          color: isSelected
                              ? context.colors.accent
                              : context.colors.border,
                          width: isSelected ? 2.5 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: context.colors.accent.withValues(
                                    alpha: 0.25,
                                  ),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: AppImage(
                        image: widget.images[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                        borderRadius: context.radius.xsBorder,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.percentage});

  final int percentage;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colors.accent,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: context.colors.accent.withValues(alpha: 0.45),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_offer_rounded, size: 12.r, color: Colors.white),
            SizedBox(width: 4.w),
            Text(
              '-$percentage%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );
}
