import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

/// A high-performance image widget that handles both asset and network images,
/// with automatic cache sizing (`cacheWidth` / `cacheHeight` / `memCacheWidth` / `memCacheHeight`)
/// to prevent high memory usage and Flutter's oversized image warnings.
class AppImage extends StatelessWidget {
  const AppImage({
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.cacheWidth,
    this.cacheHeight,
    this.enableAutoCache = true,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
    super.key,
  });

  /// Asset image constructor
  const AppImage.asset(
    this.image, {
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.cacheWidth,
    this.cacheHeight,
    this.enableAutoCache = true,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
    super.key,
  });

  /// Network image constructor
  const AppImage.network(
    this.image, {
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.cacheWidth,
    this.cacheHeight,
    this.enableAutoCache = true,
    this.placeholder,
    this.errorWidget,
    this.color,
    this.colorBlendMode,
    super.key,
  });

  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;

  /// Custom decoded physical pixel width. If null and [enableAutoCache] is true,
  /// it will be calculated automatically based on display size and device pixel ratio.
  final int? cacheWidth;

  /// Custom decoded physical pixel height. If null and [enableAutoCache] is true,
  /// it will be calculated automatically based on display size and device pixel ratio.
  final int? cacheHeight;

  /// Whether to automatically compute cache sizing (physical pixels) to save memory.
  final bool enableAutoCache;

  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Color? color;
  final BlendMode? colorBlendMode;

  bool get _isNetwork =>
      image.startsWith('http://') || image.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return _buildClipped(
        context,
        _AppImageErrorWidget(width: width, height: height),
      );
    }

    final hasFiniteWidth = width != null && width!.isFinite && width! > 0;
    final hasFiniteHeight = height != null && height!.isFinite && height! > 0;

    // If dimensions are not explicitly provided (or infinite) and auto cache is enabled,
    // measure the parent layout constraints to accurately decode the image at target resolution.
    if (enableAutoCache &&
        cacheWidth == null &&
        cacheHeight == null &&
        (!hasFiniteWidth || !hasFiniteHeight)) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final dpr = MediaQuery.devicePixelRatioOf(context);
          int? calculatedCacheWidth;
          int? calculatedCacheHeight;

          if (hasFiniteWidth) {
            calculatedCacheWidth = (width! * dpr).round();
          } else if (constraints.maxWidth.isFinite &&
              constraints.maxWidth > 0) {
            calculatedCacheWidth = (constraints.maxWidth * dpr).round();
          }

          if (hasFiniteHeight) {
            calculatedCacheHeight = (height! * dpr).round();
          } else if (constraints.maxHeight.isFinite &&
              constraints.maxHeight > 0) {
            calculatedCacheHeight = (constraints.maxHeight * dpr).round();
          }

          return _buildClipped(
            context,
            _buildImage(
              context,
              targetCacheWidth: calculatedCacheWidth,
              targetCacheHeight: calculatedCacheHeight,
            ),
          );
        },
      );
    }

    final dpr = MediaQuery.devicePixelRatioOf(context);
    final targetCacheWidth =
        cacheWidth ??
        (enableAutoCache && hasFiniteWidth ? (width! * dpr).round() : null);
    final targetCacheHeight =
        cacheHeight ??
        (enableAutoCache && hasFiniteHeight ? (height! * dpr).round() : null);

    return _buildClipped(
      context,
      _buildImage(
        context,
        targetCacheWidth: targetCacheWidth,
        targetCacheHeight: targetCacheHeight,
      ),
    );
  }

  Widget _buildClipped(BuildContext context, Widget child) {
    if (borderRadius != null && borderRadius != BorderRadius.zero) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }

  Widget _buildImage(
    BuildContext context, {
    int? targetCacheWidth,
    int? targetCacheHeight,
  }) {
    if (_isNetwork) {
      return CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        colorBlendMode: colorBlendMode,
        memCacheWidth: targetCacheWidth,
        memCacheHeight: targetCacheHeight,
        maxWidthDiskCache: targetCacheWidth != null
            ? targetCacheWidth * 2
            : null,
        maxHeightDiskCache: targetCacheHeight != null
            ? targetCacheHeight * 2
            : null,
        placeholder: (context, url) =>
            placeholder?.call(context, url) ??
            _AppImagePlaceholder(width: width, height: height),
        errorWidget: (context, url, error) =>
            errorWidget?.call(context, url, error) ??
            _AppImageErrorWidget(width: width, height: height),
      );
    }

    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
      colorBlendMode: colorBlendMode,
      cacheWidth: targetCacheWidth,
      cacheHeight: targetCacheHeight,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget?.call(context, image, error) ??
          _AppImageErrorWidget(width: width, height: height),
    );
  }
}

class _AppImagePlaceholder extends StatelessWidget {
  const _AppImagePlaceholder({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: ColoredBox(
      color: context.colors.surfaceStrong,
      child: Center(
        child: SizedBox(
          width: 20.r,
          height: 20.r,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colors.primary.withValues(alpha: 0.5),
          ),
        ),
      ),
    ),
  );
}

class _AppImageErrorWidget extends StatelessWidget {
  const _AppImageErrorWidget({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: ColoredBox(
      color: context.colors.surface,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: context.colors.textSecondary.withValues(alpha: 0.6),
          size: 24.r,
        ),
      ),
    ),
  );
}
