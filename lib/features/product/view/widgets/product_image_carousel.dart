import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_image.dart';

import 'package:mousa_store/features/product/view/widgets/product_image_viewer.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({required this.images, super.key});

  final List<String> images;

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
        height: 220.h,
        color: context.colors.surface,
        child: Icon(
          Icons.image_not_supported,
          size: 48.r,
          color: context.colors.textMuted,
        ),
      );
    }

    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 230.h,
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
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: 'product_image_${imageUrl}_$index',
                      child: AppImage(
                        image: imageUrl,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported,
                          color: context.colors.textMuted,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.zoom_in,
                        size: 18.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        if (widget.images.length > 1) ...[
          SizedBox(height: 10.h),
          ValueListenableBuilder<int>(
            valueListenable: _currentImageIndexNotifier,
            builder: (context, currentImageIndex, _) => Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.images.length, (index) {
                  final isSelected = currentImageIndex == index;

                  return GestureDetector(
                    onTap: () {
                      unawaited(_carouselController.animateToPage(index));
                      _currentImageIndexNotifier.value = index;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: AnimatedContainer(
                        duration: context.durations.fast,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          borderRadius: context.radius.xsBorder,
                          border: Border.all(
                            color: isSelected
                                ? context.colors.primary
                                : context.colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: AppImage(
                          image: widget.images[index],
                          width: 46.w,
                          height: 46.h,
                          borderRadius: context.radius.xsBorder,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
