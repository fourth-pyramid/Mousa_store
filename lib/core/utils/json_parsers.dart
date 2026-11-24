abstract final class JsonParsers {
  static double? toDoubleOrNull(Object? value) => switch (value) {
    final num n => n.toDouble(),
    final String s => double.tryParse(s.trim()),
    _ => null,
  };

  static double toDouble(Object? value, {double fallback = 0.0}) =>
      toDoubleOrNull(value) ?? fallback;

  static int? toIntOrNull(Object? value) => switch (value) {
    final int i => i,
    final num n => n.toInt(),
    final String s =>
      int.tryParse(s.trim()) ?? double.tryParse(s.trim())?.toInt(),
    _ => null,
  };

  static int toInt(Object? value, {int fallback = 0}) =>
      toIntOrNull(value) ?? fallback;
}
