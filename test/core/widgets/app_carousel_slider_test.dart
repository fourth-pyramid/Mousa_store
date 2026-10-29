import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/app_carousel_slider.dart';

Widget _buildTestWidget(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppCarouselSlider Widget Tests', () {
    testWidgets('renders items correctly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          AppCarouselSlider.items(
            height: 200,
            enableInfiniteScroll: false,
            items: const [Text('Item 1'), Text('Item 2'), Text('Item 3')],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('empty items list renders safely without error', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(AppCarouselSlider.items(height: 200, items: const [])),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('single item renders and does not loop', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          AppCarouselSlider.items(
            height: 200,
            autoPlay: true,
            items: const [Text('Only Item')],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Only Item'), findsOneWidget);
    });

    testWidgets('controller animates and jumps to logical pages', (
      tester,
    ) async {
      final controller = AppCarouselController();
      int? changedIndex;

      await tester.pumpWidget(
        _buildTestWidget(
          AppCarouselSlider.items(
            controller: controller,
            height: 200,
            enableInfiniteScroll: false,
            onPageChanged: (index) => changedIndex = index,
            items: const [Text('Page 0'), Text('Page 1'), Text('Page 2')],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Page 0'), findsOneWidget);

      controller.jumpToPage(1);
      await tester.pumpAndSettle();
      expect(changedIndex, 1);
      expect(find.text('Page 1'), findsOneWidget);

      unawaited(controller.animateToPage(2));
      await tester.pumpAndSettle();
      expect(changedIndex, 2);
      expect(find.text('Page 2'), findsOneWidget);
    });

    testWidgets('auto-play advances pages when timer fires', (tester) async {
      var changedIndex = 0;

      await tester.pumpWidget(
        _buildTestWidget(
          AppCarouselSlider.items(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(milliseconds: 500),
            autoPlayAnimationDuration: const Duration(milliseconds: 100),
            onPageChanged: (index) => changedIndex = index,
            items: const [Text('Slide A'), Text('Slide B'), Text('Slide C')],
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Slide A'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 550));
      await tester.pump(const Duration(milliseconds: 150));
      expect(changedIndex, 1);

      // Clean up timer by disposing
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    });

    testWidgets(
      'infinite scroll with fractional viewport does not throw RenderSliverFixedExtentBoxAdaptor assertion',
      (tester) async {
        tester.view.physicalSize = const Size(393, 852);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          _buildTestWidget(
            AppCarouselSlider.items(
              height: 200,
              viewportFraction: 0.88,
              items: const [
                Text('Banner 1'),
                Text('Banner 2'),
                Text('Banner 3'),
                Text('Banner 4'),
                Text('Banner 5'),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Banner 1'), findsOneWidget);
      },
    );
  });
}
