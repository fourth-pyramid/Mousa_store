import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';

Widget _buildTestWidget(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppButton Widget Tests', () {
    testWidgets('renders button text correctly in uppercase', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(AppButton(text: 'Submit', onPressed: () {})),
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

    testWidgets(
      'shows loading indicator and disables tap when isLoading is true',
      (tester) async {
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
      },
    );

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(
          AppButton(text: 'Add', icon: const Icon(Icons.add), onPressed: () {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('ADD'), findsOneWidget);
    });

    testWidgets(
      'does not expand to full screen height inside bottomNavigationBar',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const SizedBox.expand(),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Add to Cart',
                        height: 52,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final size = tester.getSize(find.byType(AppButton));
        expect(size.height, equals(52));
      },
    );
  });
}
