import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';

/// Owns the subscription, not the service or the page's BLoC.
/// Override [reconnectService] in tests instead of registering global state.
mixin AutoRefreshOnReconnect<T extends StatefulWidget> on State<T> {
  StreamSubscription<void>? _reconnectSubscription;

  IInternetConnectionService get reconnectService =>
      getIt<InternetConnectionService>();

  void onReconnect();

  @override
  void initState() {
    super.initState();
    _reconnectSubscription = reconnectService.connectivityRestoredStream.listen(
      (_) {
        if (mounted) onReconnect();
      },
    );
  }

  @override
  void dispose() {
    unawaited(_reconnectSubscription?.cancel());
    super.dispose();
  }
}
