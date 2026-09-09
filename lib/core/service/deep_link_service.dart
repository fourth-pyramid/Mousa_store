import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/cache_helper.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';

class DeepLinkService {
  DeepLinkService._();
  static final DeepLinkService instance = DeepLinkService._();

  StreamSubscription<Uri>? _linkSubscription;
  GlobalKey<NavigatorState>? _navigatorKey;
  final _appLinks = AppLinks();

  // Track the last processed link to prevent double navigation
  int? _lastProcessedId;
  DateTime? _lastProcessTime;

  /// Initialize the deep link service with navigator key
  void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
    unawaited(_handleInitialUri());
    _handleIncomingLinks();
  }

  /// Handle the initial URI when the app is launched from a link
  Future<void> _handleInitialUri() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        await handleDeepLink(initialUri);
      }
    } on Object catch (_) {
      // Handle error silently
    }
  }

  /// Listen to incoming links while the app is running
  void _handleIncomingLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      handleDeepLink,
      onError: (err) {
        // Handle error silently
      },
    );
  }

  /// Process the deep link URI and navigate to the appropriate screen
  Future<void> handleDeepLink(Uri uri) async {
    // Wait for navigator to be ready if it's not yet
    var retries = 0;
    while (_navigatorKey?.currentContext == null && retries < 10) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      retries++;
    }

    if (_navigatorKey?.currentContext == null) return;

    // Ensure price mode is set to retail if not already set to prevent errors
    if (CacheHelper.getPriceMode() == null) {
      getIt<PriceModeCubit>().setPriceMode(PriceMode.retail);
    }

    // Handle product deep links
    // Formats supported:
    // - bynona://product/123 (host: product, path: /123)
    // - https://bynona.store/product/123 (host: bynona.store, path: /product/123)

    int? productId;

    if (uri.scheme == 'bynona') {
      if (uri.host == 'product') {
        productId = int.tryParse(uri.pathSegments.firstOrNull ?? '');
      }
    } else if (uri.host == 'bynona.store' || uri.host == 'www.bynona.store') {
      if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'product') {
        productId = int.tryParse(uri.pathSegments[1]);
      }
    }

    if (productId != null) {
      // Deduplication check: ignore if it's the same product within 2 seconds
      final now = DateTime.now();
      if (_lastProcessedId == productId &&
          _lastProcessTime != null &&
          now.difference(_lastProcessTime!) < const Duration(seconds: 2)) {
        return;
      }

      _lastProcessedId = productId;
      _lastProcessTime = now;
      _navigateToProduct(productId);
    }
  }

  /// Navigate to product details screen
  void _navigateToProduct(int productId) {
    if (_navigatorKey?.currentContext == null) return;

    // Pop until the first route to ensure we have a clean stack with the home/root screen at the bottom
    _navigatorKey!.currentState?.popUntil((route) => route.isFirst);

    // Push the product details view
    unawaited(
      _navigatorKey!.currentState?.pushNamed('/product', arguments: productId),
    );
  }

  /// Generate a shareable link for a product
  static String generateProductLink(int productId) =>
      'https://bynona.store/product/$productId';

  /// Dispose the service
  void dispose() {
    if (_linkSubscription != null) {
      unawaited(_linkSubscription!.cancel());
    }
    _linkSubscription = null;
  }
}
