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
  Widget build(BuildContext context) => Directionality(
    textDirection: Directionality.of(context),
    child: Column(
      children: [
        AnimatedSize(
          duration: context.durations.normal,
          curve: Curves.easeInOut,
          child: _shouldShowBanner
              ? _NetworkBanner(
                  state: _state,
                  isRestored: _showRestored,
                  onTap: () => unawaited(_service.checkNow()),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(child: widget.child),
      ],
    ),
  );
}

class _NetworkBanner extends StatelessWidget {
  const _NetworkBanner({
    required this.state,
    required this.isRestored,
    required this.onTap,
  });

  final NetworkState state;
  final bool isRestored;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final IconData icon;
    final String message;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    if (isRestored) {
      backgroundColor = context.colors.success;
      icon = Icons.check_circle_outline_rounded;
      message = isArabic
          ? 'تمت استعادة الاتصال بالإنترنت'
          : 'Internet connection restored';
    } else if (state == NetworkState.unstable) {
      backgroundColor = context.colors.warning;
      icon = Icons.wifi_protected_setup_rounded;
      message = isArabic
          ? 'الاتصال بالإنترنت غير مستقر - اضغط للفحص'
          : 'Internet connection unstable — Tap to check';
    } else {
      backgroundColor = context.colors.error;
      icon = Icons.wifi_off_rounded;
      message =
          '${context.l10n.no_internet_title} — ${context.l10n.try_again_text}';
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
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.labelLarge.copyWith(
                      color: Colors.white,
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
