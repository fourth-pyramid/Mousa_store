import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/app_otp_field.dart';

Widget _buildTestWidget(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppOtpField Widget Tests', () {
    testWidgets('renders 6 visual character boxes by default', (tester) async {
      await tester.pumpWidget(_buildTestWidget(const AppOtpField()));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('entering text updates character boxes and calls onChanged', (
      tester,
    ) async {
      var changedValue = '';
      var completedValue = '';

      await tester.pumpWidget(
        _buildTestWidget(
          AppOtpField(
            onChanged: (val) => changedValue = val,
            onCompleted: (val) => completedValue = val,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '1234');
      await tester.pumpAndSettle();

      expect(changedValue, '1234');
      expect(completedValue, '');
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('entering 6 digits calls onCompleted', (tester) async {
      var completedValue = '';

      await tester.pumpWidget(
        _buildTestWidget(
          AppOtpField(onCompleted: (val) => completedValue = val),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '123456');
      await tester.pumpAndSettle();

      expect(completedValue, '123456');
    });

    testWidgets('non-numeric characters are filtered out by inputFormatter', (
      tester,
    ) async {
      var changedValue = '';

      await tester.pumpWidget(
        _buildTestWidget(AppOtpField(onChanged: (val) => changedValue = val)),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '12ab34');
      await tester.pumpAndSettle();

      expect(changedValue, '1234');
    });

    testWidgets('backspace and text truncation works seamlessly', (
      tester,
    ) async {
      final controller = TextEditingController(text: '123456');

      await tester.pumpWidget(
        _buildTestWidget(AppOtpField(controller: controller)),
      );
      await tester.pumpAndSettle();

      expect(find.text('6'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '123');
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('6'), findsNothing);

      controller.dispose();
    });
  });
}
