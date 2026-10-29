import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

/// A pure Flutter SDK shimmer effect widget that animates a gradient over its child.
/// Respects reduced motion preferences (`MediaQuery.disableAnimationsOf(context)`).
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
    super.key,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        widget.baseColor ??
        (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E7EB));
    final highlightColor =
        widget.highlightColor ??
        (isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF3F4F6));

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          final progress = _controller.value;
          return LinearGradient(
            begin: const Alignment(-2.0, -0.3),
            end: const Alignment(2.0, 0.3),
            stops: const [0.0, 0.45, 0.55, 1.0],
            colors: [baseColor, highlightColor, highlightColor, baseColor],
            transform: _SlidingGradientTransform(slidePercent: progress),
          ).createShader(bounds);
        },
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(
        bounds.width * (slidePercent * 2 - 1),
        0.0,
        0.0,
      );
}

/// A generic placeholder rectangle for building custom skeletons.
class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.color,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.colors.surfaceStrong;
    final effectiveRadius = shape == BoxShape.circle
        ? null
        : (borderRadius ?? context.radius.xsBorder);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveColor,
        shape: shape,
        borderRadius: effectiveRadius,
      ),
    );
  }
}
