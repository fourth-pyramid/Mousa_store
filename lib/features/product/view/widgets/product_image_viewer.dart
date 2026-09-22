import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return CachedNetworkImageProvider(imageUrl);
    }
    return AssetImage(imageUrl);
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gallery with zoom support
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              pageController: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              builder: (context, index) {
                final imageUrl = widget.images[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: _getImageProvider(imageUrl),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 4.0,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: 'product_image_${imageUrl}_$index',
                  ),
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white54,
                          size: 48.r,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'تعذر تحميل الصورة',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 32.r,
                  height: 32.r,
                  child: CircularProgressIndicator(
                    value: event == null || event.expectedTotalBytes == null
                        ? null
                        : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    color: context.colors.primary,
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            ),

            // Top Bar (Close button & counter)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: _showControls
                  ? MediaQuery.paddingOf(context).top + 8.h
                  : -80.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Close button
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

                  // Counter
                  if (widget.images.length > 1)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          '${_currentIndex + 1} / ${widget.images.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Bottom Thumbnails Strip (if multiple images)
            if (widget.images.length > 1)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                bottom: _showControls
                    ? MediaQuery.paddingOf(context).bottom + 16.h
                    : -100.h,
                left: 0,
                right: 0,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: isSelected
                                    ? context.colors.primary
                                    : Colors.white24,
                                width: isSelected ? 2.5 : 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: CachedNetworkImage(
                                imageUrl: widget.images[index],
                                width: 44.w,
                                height: 44.h,
                                fit: BoxFit.cover,
                                memCacheWidth: (44.w * 2).round(),
                                memCacheHeight: (44.h * 2).round(),
                                errorWidget: (context, url, error) => SizedBox(
                                  width: 44.w,
                                  height: 44.h,
                                  child: ColoredBox(
                                    color: Colors.white12,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.white38,
                                      size: 20.r,
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
    ),
  );
}
