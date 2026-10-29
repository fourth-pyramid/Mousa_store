import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class ProductImageViewer extends StatefulWidget {
  const ProductImageViewer({
    required this.images,
    this.initialIndex = 0,
    super.key,
  });

  final List<String> images;
  final int initialIndex;

  static Future<void> open(
    BuildContext context, {
    required List<String> images,
    int initialIndex = 0,
  }) => Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black,
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: ProductImageViewer(images: images, initialIndex: initialIndex),
      ),
    ),
  );

  @override
  State<ProductImageViewer> createState() => _ProductImageViewerState();
}

class _ProductImageViewerState extends State<ProductImageViewer> {
  late int _currentIndex;
  late PageController _pageController;
  bool _showControls = true;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _handleZoomChanged(bool isZoomed) {
    if (_isZoomed != isZoomed) {
      setState(() {
        _isZoomed = isZoomed;
      });
    }
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ── Interactive Gallery with Zoom Support ──────────
          PageView.builder(
            controller: _pageController,
            physics: _isZoomed
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _isZoomed = false;
              });
            },
            itemBuilder: (context, index) {
              final imageUrl = widget.images[index];
              return _ZoomableImagePage(
                imageUrl: imageUrl,
                heroTag: 'product_image_${imageUrl}_$index',
                onTap: _toggleControls,
                onZoomChanged: _handleZoomChanged,
              );
            },
          ),

          // ── Top Bar (Close button & counter) ───────────────
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: _showControls ? MediaQuery.paddingOf(context).top + 8 : -80,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    tooltip: 'إغلاق',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                if (widget.images.length > 1)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text(
                        '${_currentIndex + 1} / ${widget.images.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Bottom Thumbnails Strip ─────────────────────────
          if (widget.images.length > 1)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: _showControls
                  ? MediaQuery.paddingOf(context).bottom + 16
                  : -100,
              left: 0,
              right: 0,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.images.length, (index) {
                      final isSelected = index == _currentIndex;
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? context.colors.primary
                                  : Colors.white24,
                              width: isSelected ? 2.5 : 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: widget.images[index],
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                              memCacheWidth: 44 * 2,
                              memCacheHeight: 44 * 2,
                              errorWidget: (context, url, error) =>
                                  const SizedBox(
                                    width: 44,
                                    height: 44,
                                    child: ColoredBox(
                                      color: Colors.white12,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.white38,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class _ZoomableImagePage extends StatefulWidget {
  const _ZoomableImagePage({
    required this.imageUrl,
    required this.heroTag,
    required this.onTap,
    required this.onZoomChanged,
  });

  final String imageUrl;
  final String heroTag;
  final VoidCallback onTap;
  final ValueChanged<bool> onZoomChanged;

  @override
  State<_ZoomableImagePage> createState() => _ZoomableImagePageState();
}

class _ZoomableImagePageState extends State<_ZoomableImagePage>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;
  TapDownDetails? _doubleTapDetails;

  static const double _minScale = 1.0;
  static const double _maxScale = 4.0;
  static const double _doubleTapZoomScale = 2.5;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        )..addListener(() {
          if (_zoomAnimation != null) {
            _transformationController.value = _zoomAnimation!.value;
          }
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    final currentScale = _transformationController.value.getMaxScaleOnAxis();

    final Matrix4 endMatrix;
    if (currentScale > 1.05) {
      // Zoom out to 1.0
      endMatrix = Matrix4.identity();
      widget.onZoomChanged(false);
    } else {
      // Zoom in to 2.5x around tap position
      final position = _doubleTapDetails?.localPosition ?? Offset.zero;
      final x = -position.dx * (_doubleTapZoomScale - 1);
      final y = -position.dy * (_doubleTapZoomScale - 1);

      endMatrix = Matrix4.identity()
        ..storage[0] = _doubleTapZoomScale
        ..storage[5] = _doubleTapZoomScale
        ..storage[12] = x
        ..storage[13] = y;
      widget.onZoomChanged(true);
    }

    _zoomAnimation =
        Matrix4Tween(
          begin: _transformationController.value,
          end: endMatrix,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward(from: 0);
  }

  ImageProvider _getImageProvider(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImageProvider(url);
    }
    return AssetImage(url);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: widget.onTap,
    onDoubleTapDown: (details) => _doubleTapDetails = details,
    onDoubleTap: _handleDoubleTap,
    child: InteractiveViewer(
      transformationController: _transformationController,
      minScale: _minScale,
      maxScale: _maxScale,
      clipBehavior: Clip.none,
      onInteractionEnd: (_) {
        final scale = _transformationController.value.getMaxScaleOnAxis();
        widget.onZoomChanged(scale > 1.05);
      },
      child: Center(
        child: Hero(
          tag: widget.heroTag,
          child: Image(
            image: _getImageProvider(widget.imageUrl),
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: context.colors.primary,
                    strokeWidth: 2.5,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.broken_image_outlined,
                    color: Colors.white54,
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تعذر تحميل الصورة',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
