import 'package:flutter/material.dart';

/// Configuration for expanding dots indicator styling.
class ExpandingDotsConfig {
  const ExpandingDotsConfig({
    this.dotWidth = 6.0,
    this.dotHeight = 6.0,
    this.expansionFactor = 4.0,
    this.spacing = 6.0,
    this.activeDotColor = Colors.blue,
    this.dotColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  final double dotWidth;
  final double dotHeight;
  final double expansionFactor;
  final double spacing;
  final Color activeDotColor;
  final Color dotColor;
  final BorderRadius borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
}

/// A pure Flutter SDK page indicator with expanding dots effect.
/// Can be driven either by a [controller] ([PageController]) or an explicit [activeIndex].
class AppExpandingDotsIndicator extends StatelessWidget {
  const AppExpandingDotsIndicator({
    required this.count,
    this.controller,
    this.activeIndex,
    this.effect = const ExpandingDotsConfig(),
    this.onDotClicked,
    super.key,
  }) : assert(
         controller != null || activeIndex != null,
         'Either controller or activeIndex must be provided.',
       );

  final int count;
  final PageController? controller;
  final int? activeIndex;
  final ExpandingDotsConfig effect;
  final ValueChanged<int>? onDotClicked;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    if (controller != null) {
      return AnimatedBuilder(
        animation: controller!,
        builder: (context, _) {
          var page = 0.0;
          if (controller!.hasClients &&
              controller!.position.haveDimensions &&
              controller!.page != null) {
            page = controller!.page!;
          } else {
            page = controller!.initialPage.toDouble();
          }

          final logicalPage = page % count;

          return Semantics(
            label: 'Page ${(logicalPage.round() % count) + 1} of $count',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(count, (index) {
                final diff = (index - logicalPage).abs();
                final activeWeight = (1.0 - diff).clamp(0.0, 1.0);

                final currentWidth =
                    effect.dotWidth +
                    (effect.dotWidth *
                        (effect.expansionFactor - 1.0) *
                        activeWeight);
                final currentColor = Color.lerp(
                  effect.dotColor,
                  effect.activeDotColor,
                  activeWeight,
                )!;

                final dot = Container(
                  width: currentWidth,
                  height: effect.dotHeight,
                  margin: EdgeInsets.symmetric(horizontal: effect.spacing / 2),
                  decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: effect.borderRadius,
                  ),
                );

                if (onDotClicked != null) {
                  return GestureDetector(
                    onTap: () => onDotClicked!(index),
                    child: dot,
                  );
                }
                return dot;
              }),
            ),
          );
        },
      );
    }

    // Index-driven mode
    final current = (activeIndex ?? 0) % count;

    return Semantics(
      label: 'Page ${current + 1} of $count',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          final isActive = index == current;
          final width = isActive
              ? effect.dotWidth * effect.expansionFactor
              : effect.dotWidth;
          final color = isActive ? effect.activeDotColor : effect.dotColor;

          final dot = AnimatedContainer(
            duration: effect.animationDuration,
            curve: effect.animationCurve,
            width: width,
            height: effect.dotHeight,
            margin: EdgeInsets.symmetric(horizontal: effect.spacing / 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: effect.borderRadius,
            ),
          );

          if (onDotClicked != null) {
            return GestureDetector(
              onTap: () => onDotClicked!(index),
              child: dot,
            );
          }
          return dot;
        }),
      ),
    );
  }
}
