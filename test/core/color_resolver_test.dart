import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/utils/color_resolver.dart';

void main() {
  group('ColorResolver Tests', () {
    test('resolves natural titanium properly in Arabic and English', () {
      final arabicColors = ColorResolver.resolveColors('تيتانيوم طبيعي');
      expect(arabicColors, hasLength(1));
      expect(arabicColors.first, equals(const Color(0xFF9E9885)));

      final englishColors = ColorResolver.resolveColors('Natural Titanium');
      expect(englishColors, hasLength(1));
      expect(englishColors.first, equals(const Color(0xFF9E9885)));
    });

    test('resolves black in Arabic and English', () {
      final arabicColors = ColorResolver.resolveColors('أسود');
      expect(arabicColors, hasLength(1));
      expect(arabicColors.first, equals(const Color(0xFF18181B)));

      final englishColors = ColorResolver.resolveColors('Black');
      expect(englishColors, hasLength(1));
      expect(englishColors.first, equals(const Color(0xFF18181B)));
    });

    test('resolves dual colors with slash delimiter', () {
      final dualArabic = ColorResolver.resolveColors('أحمر/أسود');
      expect(dualArabic, hasLength(2));
      expect(dualArabic[0], equals(const Color(0xFFEF4444)));
      expect(dualArabic[1], equals(const Color(0xFF18181B)));

      final dualEnglish = ColorResolver.resolveColors('Red/Black');
      expect(dualEnglish, hasLength(2));
      expect(dualEnglish[0], equals(const Color(0xFFEF4444)));
      expect(dualEnglish[1], equals(const Color(0xFF18181B)));
    });

    test('resolves titanium gray properly', () {
      final arabic = ColorResolver.resolveColors('رمادي تيتانيوم');
      expect(arabic, hasLength(1));
      expect(arabic.first, equals(const Color(0xFF7D7A76)));

      final english = ColorResolver.resolveColors('Titanium Gray');
      expect(english, hasLength(1));
      expect(english.first, equals(const Color(0xFF7D7A76)));
    });

    test('resolves hex color codes correctly', () {
      final hex6 = ColorResolver.resolveColors('#FF0000');
      expect(hex6.first, equals(const Color(0xFFFF0000)));

      final hex8 = ColorResolver.resolveColors('#8000FF00');
      expect(hex8.first, equals(const Color(0x8000FF00)));
    });

    test('falls back gracefully to defaultColor for unknown strings or empty', () {
      final empty = ColorResolver.resolveColors('');
      expect(empty.first, equals(ColorResolver.defaultColor));

      final nullCol = ColorResolver.resolveColors(null);
      expect(nullCol.first, equals(ColorResolver.defaultColor));

      final unknown = ColorResolver.resolveColors('unknown_color_xyz');
      expect(unknown.first, equals(ColorResolver.defaultColor));
    });
  });
}
