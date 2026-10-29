import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/widgets/app_carousel_slider.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/product/presentation/widgets/product_image_viewer.dart';

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
  final AppCarouselController _carouselController = AppCarouselController();

  @override
  void dispose() {
    _currentImageIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 300,
        color: context.colors.surfaceStrong,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 48,
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
          height: 300,
          child: Stack(
            children: [
              // Carousel
              AppCarouselSlider.items(
                controller: _carouselController,
                height: 300,
                viewportFraction: 1,
                enableInfiniteScroll: widget.images.length > 1,
                onPageChanged: (index) {
                  _currentImageIndexNotifier.value = index;
                },
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
                        padding: const EdgeInsets.all(16),
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
                                size: 48,
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
                height: 80,
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
                  top: 14,
                  start: 14,
                  child: _DiscountBadge(percentage: widget.discountPercentage!),
                ),

              // ── Zoom hint ────────────────────────────────────────
              Positioned.directional(
                textDirection: textDirection,
                bottom: 12,
                start: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.zoom_in_rounded,
                        size: 13,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'تكبير',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
                  bottom: 12,
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
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: isActive ? 18 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(3),
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
          const SizedBox(height: 14),
          ValueListenableBuilder<int>(
            valueListenable: _currentImageIndexNotifier,
            builder: (context, currentImageIndex, _) => SizedBox(
              height: 68,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.images.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = currentImageIndex == index;

                  return GestureDetector(
                    onTap: () {
                      unawaited(_carouselController.animateToPage(index));
                      _currentImageIndexNotifier.value = index;
                    },
                    child: AnimatedContainer(
                      duration: context.durations.fast,
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(3),
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
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: context.colors.accent,
      borderRadius: BorderRadius.circular(20),
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
        const Icon(Icons.local_offer_rounded, size: 12, color: Colors.white),
        const SizedBox(width: 4),
        Text(
          '-$percentage%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}
