import 'package:flutter/material.dart';

/// Helper utility to resolve color representation from raw attribute strings
/// coming from the backend / database (e.g. Arabic/English color names, dual colors like "أحمر/أسود", hex codes, etc.).
class ColorResolver {
  const ColorResolver._();

  static const Color defaultColor = Color(0xFF6B7280);

  /// Resolves one or more colors from a raw attribute string.
  /// Dual or multi-colors (e.g., "أحمر/أسود", "Red/Black", "White & Gold")
  /// will return a list with multiple [Color] elements.
  static List<Color> resolveColors(String? value) {
    if (value == null || value.trim().isEmpty) {
      return const [defaultColor];
    }

    final trimmed = value.trim();

    // Check for delimiter patterns like '/', '|', '+', '&', ' مع ', ' و '
    final delimiters = ['/', '|', '+', '&', ' مع ', ' و '];
    for (final delimiter in delimiters) {
      if (trimmed.contains(delimiter)) {
        final parts = trimmed
            .split(delimiter)
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        if (parts.length >= 2) {
          final resolvedList = <Color>[];
          for (final part in parts) {
            final col = resolveSingleColor(part);
            resolvedList.add(col);
          }
          return resolvedList;
        }
      }
    }

    return [resolveSingleColor(trimmed)];
  }

  /// Resolves a single [Color] from an attribute string or color name.
  static Color resolveSingleColor(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return defaultColor;

    // 1. Hex color parsing (#RGB, #RRGGBB, #AARRGGBB, 0xRRGGBB)
    final hexColor = _parseHex(clean);
    if (hexColor != null) return hexColor;

    // 2. Normalize text (Arabic letters, lowercase, strip punctuation)
    final normalized = _normalizeText(clean);

    // 3. Exact dictionary lookup
    if (_namedColors.containsKey(normalized)) {
      return _namedColors[normalized]!;
    }

    // 4. Substring / Keyword lookup
    for (final entry in _keywordRules) {
      if (normalized.contains(entry.key)) {
        return entry.value;
      }
    }

    return defaultColor;
  }

  static Color? _parseHex(String raw) {
    var hex = raw.toLowerCase().trim();
    if (hex.startsWith('0x')) {
      hex = hex.substring(2);
    } else if (hex.startsWith('#')) {
      hex = hex.substring(1);
    } else {
      // Check if it's a 6 or 8 character hex without prefix
      if (hex.length != 6 && hex.length != 8) return null;
      if (!RegExp(r'^[0-9a-fA-F]+$').hasMatch(hex)) return null;
    }

    if (hex.length == 3) {
      // Convert #RGB to #RRGGBB
      hex = '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
    }

    if (hex.length == 6) {
      final parsed = int.tryParse('FF$hex', radix: 16);
      if (parsed != null) return Color(parsed);
    } else if (hex.length == 8) {
      final parsed = int.tryParse(hex, radix: 16);
      if (parsed != null) return Color(parsed);
    }
    return null;
  }

  static String _normalizeText(String input) {
    var text = input.toLowerCase().trim();

    // Remove Arabic Tashkeel / Diacritics
    text = text.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '');

    // Normalize Arabic letters
    text = text
        .replaceAll(RegExp('[أإآٱ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    // Strip common descriptive prefixes
    if (text.startsWith('لون ')) text = text.substring(4).trim();
    if (text.startsWith('color ')) text = text.substring(6).trim();

    return text;
  }

  static final Map<String, Color> _namedColors = {
    // Titanium variations
    'تيتانيوم طبيعي': const Color(0xFF9E9885),
    'natural titanium': const Color(0xFF9E9885),
    'تيتانيوم صحراوي': const Color(0xFFC5A880),
    'desert titanium': const Color(0xFFC5A880),
    'تيتانيوم اسود': const Color(0xFF2C2C2E),
    'black titanium': const Color(0xFF2C2C2E),
    'تيتانيوم ابيض': const Color(0xFFE8E8E6),
    'white titanium': const Color(0xFFE8E8E6),
    'تيتانيوم ازرق': const Color(0xFF384353),
    'blue titanium': const Color(0xFF384353),
    'تيتانيوم رمادي': const Color(0xFF7D7A76),
    'رمادي تيتانيوم': const Color(0xFF7D7A76),
    'titanium gray': const Color(0xFF7D7A76),
    'titanium grey': const Color(0xFF7D7A76),
    'تيتانيوم': const Color(0xFF9E9885),
    'titanium': const Color(0xFF9E9885),

    // Monochromes
    'اسود': const Color(0xFF18181B),
    'black': const Color(0xFF18181B),
    'فحمي': const Color(0xFF27272A),
    'charcoal': const Color(0xFF27272A),
    'ميدنايت': const Color(0xFF191C24),
    'midnight': const Color(0xFF191C24),
    'ابيض': const Color(0xFFFFFFFF),
    'white': const Color(0xFFFFFFFF),
    'ستارلايت': const Color(0xFFF9F6EE),
    'starlight': const Color(0xFFF9F6EE),
    'اوف وايت': const Color(0xFFFAF9F6),
    'off white': const Color(0xFFFAF9F6),
    'off-white': const Color(0xFFFAF9F6),
    'رمادي': const Color(0xFF6B7280),
    'رصاصي': const Color(0xFF6B7280),
    'gray': const Color(0xFF6B7280),
    'grey': const Color(0xFF6B7280),
    'رمادي غامق': const Color(0xFF374151),
    'رمادي داكن': const Color(0xFF374151),
    'dark gray': const Color(0xFF374151),
    'dark grey': const Color(0xFF374151),
    'رمادي فاتح': const Color(0xFFD1D5DB),
    'light gray': const Color(0xFFD1D5DB),
    'light grey': const Color(0xFFD1D5DB),
    'رمادي فلكي': const Color(0xFF4B4846),
    'space gray': const Color(0xFF4B4846),
    'space grey': const Color(0xFF4B4846),
    'فضي': const Color(0xFFE5E7EB),
    'silver': const Color(0xFFE5E7EB),
    'بلاتيني': const Color(0xFFE5E4E2),
    'platinum': const Color(0xFFE5E4E2),

    // Reds & Pinks
    'احمر': const Color(0xFFEF4444),
    'red': const Color(0xFFEF4444),
    'برودكت رد': const Color(0xFFDC2626),
    'product red': const Color(0xFFDC2626),
    'احمر داكن': const Color(0xFF991B1B),
    'dark red': const Color(0xFF991B1B),
    'نبيتي': const Color(0xFF800020),
    'خمري': const Color(0xFF800020),
    'عنابي': const Color(0xFF800020),
    'بورجوندي': const Color(0xFF800020),
    'burgundy': const Color(0xFF800020),
    'maroon': const Color(0xFF800020),
    'wine': const Color(0xFF722F37),
    'وردي': const Color(0xFFEC4899),
    'زهري': const Color(0xFFEC4899),
    'بمبي': const Color(0xFFEC4899),
    'pink': const Color(0xFFEC4899),
    'وردي فاتح': const Color(0xFFFBCFE8),
    'light pink': const Color(0xFFFBCFE8),
    'روز جولد': const Color(0xFFB76E79),
    'وردي ذهبي': const Color(0xFFB76E79),
    'rose gold': const Color(0xFFB76E79),
    'مرجاني': const Color(0xFFFF7F50),
    'coral': const Color(0xFFFF7F50),

    // Blues
    'ازرق': const Color(0xFF2563EB),
    'blue': const Color(0xFF2563EB),
    'كحلي': const Color(0xFF1E3A8A),
    'ازرق داكن': const Color(0xFF1E3A8A),
    'navy': const Color(0xFF1E3A8A),
    'navy blue': const Color(0xFF1E3A8A),
    'dark blue': const Color(0xFF1E3A8A),
    'سماوي': const Color(0xFF38BDF8),
    'ازرق فاتح': const Color(0xFF38BDF8),
    'لبني': const Color(0xFF38BDF8),
    'sky blue': const Color(0xFF38BDF8),
    'light blue': const Color(0xFF38BDF8),
    'cyan': const Color(0xFF06B6D4),
    'ازرق سييرا': const Color(0xFF698996),
    'sierra blue': const Color(0xFF698996),
    'ازرق باسيفيك': const Color(0xFF2E4E58),
    'pacific blue': const Color(0xFF2E4E58),
    'تركواز': const Color(0xFF14B8A6),
    'فيروزي': const Color(0xFF14B8A6),
    'turquoise': const Color(0xFF14B8A6),
    'teal': const Color(0xFF0D9488),

    // Greens
    'اخضر': const Color(0xFF10B981),
    'green': const Color(0xFF10B981),
    'اخضر داكن': const Color(0xFF065F46),
    'dark green': const Color(0xFF065F46),
    'زيتي': const Color(0xFF4D5D39),
    'زيتوني': const Color(0xFF4D5D39),
    'olive': const Color(0xFF4D5D39),
    'نعناعي': const Color(0xFF6EE7B7),
    'مينت': const Color(0xFF6EE7B7),
    'mint': const Color(0xFF6EE7B7),
    'mint green': const Color(0xFF6EE7B7),
    'زمردي': const Color(0xFF047857),
    'emerald': const Color(0xFF047857),
    'اخضر تفاحي': const Color(0xFF84CC16),
    'lime': const Color(0xFF84CC16),

    // Yellows, Oranges, Browns
    'اصفر': const Color(0xFFEAB308),
    'yellow': const Color(0xFFEAB308),
    'خردلي': const Color(0xFFCA8A04),
    'mustard': const Color(0xFFCA8A04),
    'برتقالي': const Color(0xFFF97316),
    'orange': const Color(0xFFF97316),
    'خوخي': const Color(0xFFFDBA74),
    'peach': const Color(0xFFFDBA74),
    'ذهبي': const Color(0xFFD4AF37),
    'gold': const Color(0xFFD4AF37),
    'برونزي': const Color(0xFFCD7F32),
    'bronze': const Color(0xFFCD7F32),
    'نحاسي': const Color(0xFFB87333),
    'copper': const Color(0xFFB87333),
    'بني': const Color(0xFF78350F),
    'brown': const Color(0xFF78350F),
    'هافان': const Color(0xFFA06235),
    'havana': const Color(0xFFA06235),
    'جملي': const Color(0xFFA06235),
    'camel': const Color(0xFFA06235),
    'كراميل': const Color(0xFFB45309),
    'caramel': const Color(0xFFB45309),
    'بيج': const Color(0xFFD4C5B9),
    'beige': const Color(0xFFD4C5B9),
    'كريمي': const Color(0xFFFDFBF7),
    'cream': const Color(0xFFFDFBF7),
    'عاجي': const Color(0xFFFFFFF0),
    'ivory': const Color(0xFFFFFFF0),

    // Purples
    'بنفسجي': const Color(0xFF8B5CF6),
    'ارجواني': const Color(0xFF8B5CF6),
    'موف': const Color(0xFF8B5CF6),
    'purple': const Color(0xFF8B5CF6),
    'violet': const Color(0xFF7C3AED),
    'لافندر': const Color(0xFFC4B5FD),
    'خزامي': const Color(0xFFC4B5FD),
    'lavender': const Color(0xFFC4B5FD),
    'lilac': const Color(0xFFC4B5FD),
  };

  /// Keyword fallback rules when string contains specific words.
  /// Ordered by specificity (compound/distinct first, generic last).
  static final List<MapEntry<String, Color>> _keywordRules = [
    const MapEntry('روز جولد', Color(0xFFB76E79)),
    const MapEntry('rose gold', Color(0xFFB76E79)),
    const MapEntry('تيتانيوم صحراوي', Color(0xFFC5A880)),
    const MapEntry('desert titanium', Color(0xFFC5A880)),
    const MapEntry('تيتانيوم طبيعي', Color(0xFF9E9885)),
    const MapEntry('natural titanium', Color(0xFF9E9885)),
    const MapEntry('تيتانيوم', Color(0xFF9E9885)),
    const MapEntry('titanium', Color(0xFF9E9885)),
    const MapEntry('سماوي', Color(0xFF38BDF8)),
    const MapEntry('كحلي', Color(0xFF1E3A8A)),
    const MapEntry('نبيتي', Color(0xFF800020)),
    const MapEntry('عنابي', Color(0xFF800020)),
    const MapEntry('خمري', Color(0xFF800020)),
    const MapEntry('زيتي', Color(0xFF4D5D39)),
    const MapEntry('ذهبي', Color(0xFFD4AF37)),
    const MapEntry('gold', Color(0xFFD4AF37)),
    const MapEntry('فضي', Color(0xFFE5E7EB)),
    const MapEntry('silver', Color(0xFFE5E7EB)),
    const MapEntry('برونزي', Color(0xFFCD7F32)),
    const MapEntry('bronze', Color(0xFFCD7F32)),
    const MapEntry('اسود', Color(0xFF18181B)),
    const MapEntry('black', Color(0xFF18181B)),
    const MapEntry('ابيض', Color(0xFFFFFFFF)),
    const MapEntry('white', Color(0xFFFFFFFF)),
    const MapEntry('احمر', Color(0xFFEF4444)),
    const MapEntry('red', Color(0xFFEF4444)),
    const MapEntry('ازرق', Color(0xFF2563EB)),
    const MapEntry('blue', Color(0xFF2563EB)),
    const MapEntry('اخضر', Color(0xFF10B981)),
    const MapEntry('green', Color(0xFF10B981)),
    const MapEntry('اصفر', Color(0xFFEAB308)),
    const MapEntry('yellow', Color(0xFFEAB308)),
    const MapEntry('برتقالي', Color(0xFFF97316)),
    const MapEntry('orange', Color(0xFFF97316)),
    const MapEntry('وردي', Color(0xFFEC4899)),
    const MapEntry('زهري', Color(0xFFEC4899)),
    const MapEntry('بمبي', Color(0xFFEC4899)),
    const MapEntry('pink', Color(0xFFEC4899)),
    const MapEntry('بنفسجي', Color(0xFF8B5CF6)),
    const MapEntry('موف', Color(0xFF8B5CF6)),
    const MapEntry('purple', Color(0xFF8B5CF6)),
    const MapEntry('بني', Color(0xFF78350F)),
    const MapEntry('brown', Color(0xFF78350F)),
    const MapEntry('بيج', Color(0xFFD4C5B9)),
    const MapEntry('beige', Color(0xFFD4C5B9)),
    const MapEntry('رمادي', Color(0xFF6B7280)),
    const MapEntry('رصاصي', Color(0xFF6B7280)),
    const MapEntry('gray', Color(0xFF6B7280)),
    const MapEntry('grey', Color(0xFF6B7280)),
  ];
}
