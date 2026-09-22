import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';

Widget _buildTestWidget(Widget child) => ScreenUtilInit(
  designSize: const Size(375, 812),
  builder: (_, _) => MaterialApp(home: Scaffold(body: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppEmptyState Widget Tests', () {
    testWidgets('renders title and description correctly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const AppEmptyState(
            title: 'No Items Found',
            description: 'Please check back later or try a different search.',
            icon: Icons.search_off,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 600));

      expect(find.text('NO ITEMS FOUND'), findsOneWidget);
      expect(
        find.text('Please check back later or try a different search.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('triggers primary and secondary actions when tapped', (
      tester,
    ) async {
      var primaryTapped = false;
      var secondaryTapped = false;

      await tester.pumpWidget(
        _buildTestWidget(
          AppEmptyState(
            title: 'Empty Cart',
            actionLabel: 'Shop Now',
            onActionTap: () => primaryTapped = true,
            secondaryActionLabel: 'Explore Categories',
            onSecondaryActionTap: () => secondaryTapped = true,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 600));

      await tester.tap(find.text('SHOP NOW'));
      await tester.pump();
      expect(primaryTapped, isTrue);

      await tester.tap(find.text('EXPLORE CATEGORIES'));
      await tester.pump();
      expect(secondaryTapped, isTrue);
    });
  });
}
