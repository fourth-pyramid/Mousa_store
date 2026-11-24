import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/widgets/auto_refresh_on_reconnect.dart';

class _Service extends Mock implements IInternetConnectionService {}

class _Page extends StatefulWidget {
  const _Page(this.service, this.onRefresh);
  final IInternetConnectionService service;
  final VoidCallback onRefresh;
  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> with AutoRefreshOnReconnect<_Page> {
  @override
  IInternetConnectionService get reconnectService => widget.service;
  @override
  void onReconnect() => widget.onRefresh();
  @override
  Widget build(BuildContext context) => const SizedBox();
}

void main() {
  testWidgets('Subscribes once and cancels when the page is disposed', (
    tester,
  ) async {
    final stream = StreamController<void>.broadcast();
    final service = _Service();
    when(() => service.connectivityRestoredStream)
        .thenAnswer((_) => stream.stream);
    var count = 0;
    await tester.pumpWidget(_Page(service, () => count++));
    stream.add(null);
    await tester.pump();
    expect(count, 1);
    await tester.pumpWidget(const SizedBox());
    expect(stream.hasListener, isFalse);
    stream.add(null);
    await tester.pump();
    expect(count, 1);
    await stream.close();
  });
}
