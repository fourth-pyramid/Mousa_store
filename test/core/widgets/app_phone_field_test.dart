import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/app_phone_field.dart';

Widget _buildTestWidget(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppPhoneField Widget Tests', () {
    test('PhoneNumber completeNumber formats correctly', () {
      const pn1 = PhoneNumber(
        countryCode: '20',
        countryISOCode: 'EG',
        number: '01012345678',
      );
      expect(pn1.completeNumber, '+201012345678');

      const pn2 = PhoneNumber(
        countryCode: '966',
        countryISOCode: 'SA',
        number: '501234567',
      );
      expect(pn2.completeNumber, '+966501234567');
    });

    testWidgets('renders default country Egypt flag and dial code', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestWidget(const AppPhoneField()));
      await tester.pumpAndSettle();

      expect(find.text('🇪🇬'), findsOneWidget);
      expect(find.text('+20'), findsOneWidget);
    });

    testWidgets('entering valid phone calls onChanged with PhoneNumber', (
      tester,
    ) async {
      PhoneNumber? result;

      await tester.pumpWidget(
        _buildTestWidget(AppPhoneField(onChanged: (pn) => result = pn)),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), '01012345678');
      await tester.pumpAndSettle();

      expect(result, isNotNull);
      expect(result!.countryISOCode, 'EG');
      expect(result!.countryCode, '20');
      expect(result!.completeNumber, '+201012345678');
    });

    testWidgets('form validation fails on empty and invalid Egyptian numbers', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        _buildTestWidget(
          Form(
            key: formKey,
            child: const AppPhoneField(invalidNumberMessage: 'Invalid Number'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Test empty
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pumpAndSettle();
      expect(find.text('Invalid Number'), findsOneWidget);

      // Test invalid short number
      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.pumpAndSettle();
      expect(formKey.currentState!.validate(), isFalse);

      // Test valid Egyptian mobile number
      await tester.enterText(find.byType(TextFormField), '01012345678');
      await tester.pumpAndSettle();
      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets(
      'pasting international number with + parses country and national number',
      (tester) async {
        PhoneNumber? result;

        await tester.pumpWidget(
          _buildTestWidget(AppPhoneField(onChanged: (pn) => result = pn)),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField), '+966501234567');
        await tester.pumpAndSettle();

        expect(result, isNotNull);
        expect(result!.countryISOCode, 'SA');
        expect(result!.completeNumber, '+966501234567');
        expect(find.text('🇸🇦'), findsOneWidget);
      },
    );

    testWidgets('tapping country selector opens search bottom sheet', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestWidget(const AppPhoneField()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('+20'));
      await tester.pumpAndSettle();

      expect(find.text('Saudi Arabia'), findsOneWidget);
      expect(find.text('Kuwait'), findsOneWidget);

      // Select Saudi Arabia
      await tester.tap(find.text('Saudi Arabia'));
      await tester.pumpAndSettle();

      expect(find.text('🇸🇦'), findsOneWidget);
      expect(find.text('+966'), findsOneWidget);
    });
  });
}
