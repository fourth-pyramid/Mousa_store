import 'dart:async';
import 'package:flutter/material.dart';

/// Controller for [AppCarouselSlider] to programmatically control page changes.
class AppCarouselController {
  _AppCarouselSliderState? _state;

  void _attach(_AppCarouselSliderState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// Whether the controller is currently attached to a carousel.
  bool get isAttached => _state != null;

  /// Animates to the given logical page [index].
  Future<void> animateToPage(
    int index, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    await _state?.animateToLogicalPage(index, duration: duration, curve: curve);
  }

  /// Jumps directly to the given logical page [index].
  void jumpToPage(int index) {
    _state?.jumpToLogicalPage(index);
  }

  /// Animates to the next page.
  Future<void> nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    await _state?.nextPage(duration: duration, curve: curve);
  }

  /// Animates to the previous page.
  Future<void> previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    await _state?.previousPage(duration: duration, curve: curve);
  }

  /// Starts or resumes autoplay.
  void startAutoPlay() {
    _state?.startAutoPlay();
  }

  /// Stops or pauses autoplay.
  void stopAutoPlay() {
    _state?.stopAutoPlay();
  }
}

/// A pure Flutter SDK carousel slider replacing `carousel_slider`.
class AppCarouselSlider extends StatefulWidget {
  const AppCarouselSlider({
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 600),
    this.autoPlayCurve = Curves.easeInOut,
    this.enlargeCenterPage = false,
    this.enlargeFactor = 0.15,
    this.onPageChanged,
    this.scrollPhysics,
    this.scrollDirection = Axis.horizontal,
    this.padEnds = true,
    super.key,
  });

  /// Factory constructor taking a list of items directly.
  factory AppCarouselSlider.items({
    required List<Widget> items,
    Key? key,
    AppCarouselController? controller,
    double? height,
    double aspectRatio = 16 / 9,
    double viewportFraction = 0.8,
    int initialPage = 0,
    bool enableInfiniteScroll = true,
    bool autoPlay = false,
    Duration autoPlayInterval = const Duration(seconds: 4),
    Duration autoPlayAnimationDuration = const Duration(milliseconds: 600),
    Curve autoPlayCurve = Curves.easeInOut,
    bool enlargeCenterPage = false,
    double enlargeFactor = 0.15,
    void Function(int index)? onPageChanged,
    ScrollPhysics? scrollPhysics,
    Axis scrollDirection = Axis.horizontal,
    bool padEnds = true,
  }) => AppCarouselSlider(
    key: key,
    itemCount: items.length,
    itemBuilder: (context, index, realIndex) => items[index],
    controller: controller,
    height: height,
    aspectRatio: aspectRatio,
    viewportFraction: viewportFraction,
    initialPage: initialPage,
    enableInfiniteScroll: enableInfiniteScroll,
    autoPlay: autoPlay,
    autoPlayInterval: autoPlayInterval,
    autoPlayAnimationDuration: autoPlayAnimationDuration,
    autoPlayCurve: autoPlayCurve,
    enlargeCenterPage: enlargeCenterPage,
    enlargeFactor: enlargeFactor,
    onPageChanged: onPageChanged,
    scrollPhysics: scrollPhysics,
    scrollDirection: scrollDirection,
    padEnds: padEnds,
  );

  final int itemCount;
  final Widget Function(BuildContext context, int index, int realIndex)
  itemBuilder;
  final AppCarouselController? controller;
  final double? height;
  final double aspectRatio;
  final double viewportFraction;
  final int initialPage;
  final bool enableInfiniteScroll;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final bool enlargeCenterPage;
  final double enlargeFactor;
  final void Function(int index)? onPageChanged;
  final ScrollPhysics? scrollPhysics;
  final Axis scrollDirection;
  final bool padEnds;

  @override
  State<AppCarouselSlider> createState() => _AppCarouselSliderState();
}

class _AppCarouselSliderState extends State<AppCarouselSlider>
    with WidgetsBindingObserver {
  late PageController _pageController;
  Timer? _autoPlayTimer;
  bool _isAutoPlayPaused = false;
  bool _isAnimating = false;
  late int _currentPage;

  static const int _infiniteMultiplier = 10000;

  bool get _isInfinite => widget.enableInfiniteScroll && widget.itemCount > 1;

  int get _virtualInitialPage {
    if (!_isInfinite) {
      return widget.initialPage.clamp(
        0,
        (widget.itemCount - 1).clamp(0, double.infinity).toInt(),
      );
    }
    final middle = (_infiniteMultiplier * widget.itemCount) ~/ 2;
    return middle - (middle % widget.itemCount) + widget.initialPage;
  }

  int _toLogicalIndex(int virtualIndex) {
    if (widget.itemCount <= 0) return 0;
    return ((virtualIndex % widget.itemCount) + widget.itemCount) %
        widget.itemCount;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentPage = _virtualInitialPage;
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: widget.viewportFraction,
    );
    widget.controller?._attach(this);

    if (widget.autoPlay && widget.itemCount > 1) {
      _startAutoPlayTimer();
    }
  }

  @override
  void didUpdateWidget(covariant AppCarouselSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }

    if (oldWidget.viewportFraction != widget.viewportFraction) {
      final currentPos = _pageController.hasClients
          ? _pageController.page?.round() ?? _currentPage
          : _currentPage;
      _pageController.dispose();
      _pageController = PageController(
        initialPage: currentPos,
        viewportFraction: widget.viewportFraction,
      );
    }

    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval ||
        oldWidget.itemCount != widget.itemCount) {
      _stopAutoPlayTimer();
      if (widget.autoPlay && widget.itemCount > 1 && !_isAutoPlayPaused) {
        _startAutoPlayTimer();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _isAutoPlayPaused = false;
      if (widget.autoPlay && widget.itemCount > 1) {
        _startAutoPlayTimer();
      }
    } else {
      _isAutoPlayPaused = true;
      _stopAutoPlayTimer();
    }
  }

  void _startAutoPlayTimer() {
    _stopAutoPlayTimer();
    if (!mounted || widget.itemCount <= 1 || !widget.autoPlay) return;

    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted || _isAutoPlayPaused || _isAnimating) return;
      if (!_pageController.hasClients) return;

      final nextPage = _pageController.page!.round() + 1;
      if (!_isInfinite && nextPage >= widget.itemCount) {
        // Loop back to start if bounded
        unawaited(
          animateToLogicalPage(
            0,
            duration: widget.autoPlayAnimationDuration,
            curve: widget.autoPlayCurve,
          ),
        );
      } else {
        _isAnimating = true;
        unawaited(
          _pageController
              .animateToPage(
                nextPage,
                duration: widget.autoPlayAnimationDuration,
                curve: widget.autoPlayCurve,
              )
              .then((_) => _isAnimating = false)
              .catchError((_) => _isAnimating = false),
        );
      }
    });
  }

  void _stopAutoPlayTimer() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  void startAutoPlay() {
    _isAutoPlayPaused = false;
    _startAutoPlayTimer();
  }

  void stopAutoPlay() {
    _isAutoPlayPaused = true;
    _stopAutoPlayTimer();
  }

  Future<void> animateToLogicalPage(
    int logicalIndex, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    if (!_pageController.hasClients || widget.itemCount == 0) return;

    if (!_isInfinite) {
      await _pageController.animateToPage(
        logicalIndex.clamp(0, widget.itemCount - 1),
        duration: duration,
        curve: curve,
      );
      return;
    }

    final currentVirtual = _pageController.page!.round();
    final currentLogical = _toLogicalIndex(currentVirtual);
    final diff = logicalIndex - currentLogical;
    final targetVirtual = currentVirtual + diff;

    await _pageController.animateToPage(
      targetVirtual,
      duration: duration,
      curve: curve,
    );
  }

  void jumpToLogicalPage(int logicalIndex) {
    if (!_pageController.hasClients || widget.itemCount == 0) return;

    if (!_isInfinite) {
      _pageController.jumpToPage(logicalIndex.clamp(0, widget.itemCount - 1));
      return;
    }

    final currentVirtual = _pageController.page!.round();
    final currentLogical = _toLogicalIndex(currentVirtual);
    final diff = logicalIndex - currentLogical;
    final targetVirtual = currentVirtual + diff;

    _pageController.jumpToPage(targetVirtual);
  }

  Future<void> nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    if (!_pageController.hasClients || widget.itemCount == 0) return;
    await _pageController.nextPage(duration: duration, curve: curve);
  }

  Future<void> previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    if (!_pageController.hasClients || widget.itemCount == 0) return;
    await _pageController.previousPage(duration: duration, curve: curve);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.controller?._detach();
    _stopAutoPlayTimer();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return SizedBox(height: widget.height, child: const SizedBox.shrink());
    }

    Widget pageView = PageView.builder(
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      physics: widget.scrollPhysics,
      padEnds: widget.padEnds,
      // For infinite scroll, passing null makes the scroll extent infinite,
      // avoiding finite floating-point precision mismatch assertions in
      // RenderSliverFixedExtentBoxAdaptor (introduced in Flutter 3.47+).
      itemCount: _isInfinite ? null : widget.itemCount,
      onPageChanged: (virtualIndex) {
        final logicalIndex = _toLogicalIndex(virtualIndex);
        widget.onPageChanged?.call(logicalIndex);
      },
      itemBuilder: (context, virtualIndex) {
        final logicalIndex = _toLogicalIndex(virtualIndex);

        if (!widget.enlargeCenterPage) {
          return widget.itemBuilder(context, logicalIndex, virtualIndex);
        }

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            var value = 0.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - virtualIndex;
            } else {
              value = (_currentPage - virtualIndex).toDouble();
            }
            final distortionRatio = (1 - (value.abs() * widget.enlargeFactor))
                .clamp(0.0, 1.0);
            final scale = Curves.easeOut.transform(distortionRatio);

            return Transform.scale(scale: scale, child: child);
          },
          child: widget.itemBuilder(context, logicalIndex, virtualIndex),
        );
      },
    );

    // Pause autoplay on user touch interaction
    if (widget.autoPlay) {
      pageView = Listener(
        onPointerDown: (_) {
          _isAutoPlayPaused = true;
          _stopAutoPlayTimer();
        },
        onPointerUp: (_) {
          _isAutoPlayPaused = false;
          _startAutoPlayTimer();
        },
        onPointerCancel: (_) {
          _isAutoPlayPaused = false;
          _startAutoPlayTimer();
        },
        child: pageView,
      );
    }

    if (widget.height != null) {
      return SizedBox(height: widget.height, child: pageView);
    }

    return AspectRatio(aspectRatio: widget.aspectRatio, child: pageView);
  }
}
