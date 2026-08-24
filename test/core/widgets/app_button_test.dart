import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';

Widget _buildTestWidget(Widget child) => ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, _) => MaterialApp(
        home: Scaffold(body: Center(child: child)),
      ),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppButton Widget Tests', () {
    testWidgets('renders button text correctly in uppercase', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          AppButton(
            text: 'Submit',
            onPressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SUBMIT'), findsOneWidget);
    });

    testWidgets('triggers onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        _buildTestWidget(
          AppButton(
            text: 'Click Me',
            onPressed: () {
              tapped = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('shows loading indicator and disables tap when isLoading is true', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        _buildTestWidget(
          AppButton(
            text: 'Loading',
            isLoading: true,
            onPressed: () {
              tapped = true;
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('LOADING'), findsNothing);

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(tapped, isFalse);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          AppButton(
            text: 'Add',
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('ADD'), findsOneWidget);
    });
  });
}
