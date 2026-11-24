import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

/// Root UI wrapper that displays a persistent, non-intrusive status banner
/// whenever the network is disconnected, unstable, or recently restored.
class InternetConnectionWrapper extends StatefulWidget {
  const InternetConnectionWrapper({
    required this.child,
    this.connectionService,
    super.key,
  });

  final Widget child;
  final IInternetConnectionService? connectionService;

  @override
  State<InternetConnectionWrapper> createState() =>
      _InternetConnectionWrapperState();
}

class _InternetConnectionWrapperState extends State<InternetConnectionWrapper> {
  late final IInternetConnectionService _service;
  StreamSubscription<NetworkState>? _subscription;
  Timer? _hideTimer;

  late NetworkState _state;
  bool _showRestored = false;
  Widget? _lastVisibleBanner;

  @override
  void initState() {
    super.initState();
    _service = widget.connectionService ?? getIt<InternetConnectionService>();
    _state = _service.currentState;

    _subscription = _service.stateStream.listen((newState) {
      if (!mounted) return;
      final previousState = _state;
      setState(() {
        _state = newState;
        if (previousState == NetworkState.disconnected &&
            newState == NetworkState.connected) {
          _showRestored = true;
          _hideTimer?.cancel();
          _hideTimer = Timer(const Duration(milliseconds: 1800), () {
            if (mounted) {
              setState(() {
                _showRestored = false;
              });
            }
          });
        } else if (newState == NetworkState.disconnected ||
            newState == NetworkState.unstable) {
          _showRestored = false;
          _hideTimer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    _hideTimer?.cancel();
    super.dispose();
  }

  bool get _shouldShowBanner {
    if (_showRestored) return true;
    if (_state == NetworkState.disconnected ||
        _state == NetworkState.unstable) {
      return true;
    }
    // On cold start checking -> connected, keep banner hidden
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final showBanner = _shouldShowBanner;
    final mediaQuery = MediaQuery.of(context);
    final withoutTop = mediaQuery.removePadding(removeTop: true);
    // Retain the outgoing banner during collapse, rather than painting an error
    // banner for the now-connected state on its last animation frames.
    if (showBanner) {
      _lastVisibleBanner = _NetworkBanner(
        state: _state,
        issue: _service.lastIssue,
        isRestored: _showRestored,
        onTap: () => unawaited(_service.checkNow()),
      );
    }
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: showBanner ? 1 : 0),
      duration: context.durations.normal,
      curve: Curves.easeInOut,
      builder: (context, progress, child) => Column(
        children: [
          ClipRect(
            child: Align(
              heightFactor: progress,
              child: progress == 0 && !showBanner
                  ? const SizedBox.shrink()
                  : _lastVisibleBanner ?? const SizedBox.shrink(),
            ),
          ),
          Expanded(
            child: MediaQuery(
              data: mediaQuery.copyWith(
                padding: EdgeInsets.lerp(
                  mediaQuery.padding,
                  withoutTop.padding,
                  progress,
                ),
                viewPadding: EdgeInsets.lerp(
                  mediaQuery.viewPadding,
                  withoutTop.viewPadding,
                  progress,
                ),
              ),
              child: child!,
            ),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}

class _NetworkBanner extends StatelessWidget {
  const _NetworkBanner({
    required this.state,
    required this.issue,
    required this.isRestored,
    required this.onTap,
  });

  final NetworkState state;
  final NetworkIssue issue;
  final bool isRestored;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color contentColor;
    final IconData icon;
    final String message;

    if (isRestored) {
      backgroundColor = context.colors.success;
      contentColor = context.colors.onSuccess;
      icon = Icons.check_circle_outline_rounded;
      message = context.l10n.internet_restored_banner;
    } else if (state == NetworkState.unstable) {
      backgroundColor = context.colors.warning;
      contentColor = context.colors.onWarning;
      icon = Icons.wifi_protected_setup_rounded;
      message = context.l10n.internet_unstable_banner;
    } else {
      switch (issue) {
        case NetworkIssue.captivePortal:
          backgroundColor = context.colors.warning;
          contentColor = context.colors.onWarning;
          icon = Icons.wifi_lock_rounded;
          message = context.l10n.internet_captive_portal_banner;
        case NetworkIssue.noInternet:
          backgroundColor = context.colors.warning;
          contentColor = context.colors.onWarning;
          icon = Icons.wifi_find_rounded;
          message = context.l10n.internet_no_access_banner;
        case NetworkIssue.noInterface:
        case NetworkIssue.none:
          backgroundColor = context.colors.error;
          contentColor = context.colors.onError;
          icon = Icons.wifi_off_rounded;
          message =
              '${context.l10n.no_internet_title} — ${context.l10n.try_again_text}';
      }
    }

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: contentColor, size: 18),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.labelLarge.copyWith(
                      color: contentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
