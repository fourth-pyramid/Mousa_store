import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/app_page_indicator.dart';

Widget _buildTestWidget(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppExpandingDotsIndicator Widget Tests', () {
    testWidgets('renders correct number of dots for index-driven mode', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const AppExpandingDotsIndicator(
            count: 4,
            activeIndex: 1,
            effect: ExpandingDotsConfig(
              dotWidth: 8,
              dotHeight: 8,
              expansionFactor: 3,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedContainer), findsNWidgets(4));
      expect(find.bySemanticsLabel('Page 2 of 4'), findsOneWidget);
    });

    testWidgets('calls onDotClicked when a dot is tapped', (tester) async {
      int? clickedIndex;

      await tester.pumpWidget(
        _buildTestWidget(
          AppExpandingDotsIndicator(
            count: 3,
            activeIndex: 0,
            onDotClicked: (index) => clickedIndex = index,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AnimatedContainer).at(2));
      await tester.pumpAndSettle();

      expect(clickedIndex, 2);
    });

    testWidgets('renders with PageController smoothly', (tester) async {
      final controller = PageController();

      await tester.pumpWidget(
        _buildTestWidget(
          AppExpandingDotsIndicator(count: 3, controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsWidgets);
      expect(find.bySemanticsLabel('Page 1 of 3'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('renders SizedBox.shrink when count <= 1', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const AppExpandingDotsIndicator(count: 1, activeIndex: 0),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedContainer), findsNothing);
    });
  });
}
