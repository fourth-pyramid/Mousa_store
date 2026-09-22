import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';

/// SPORTCORE Controlled Radius System — premium upgrade
abstract class AppRadius {
  static double get xs => 8.r;
  static double get sm => 12.r;
  static double get md => 16.r;
  static double get lg => 24.r;
  static double get xl => 32.r;
  static double get pill => 999.r;

  // Pre-built BorderRadius helpers
  static BorderRadius get xsBorder => BorderRadius.circular(xs);
  static BorderRadius get smBorder => BorderRadius.circular(sm);
  static BorderRadius get mdBorder => BorderRadius.circular(md);
  static BorderRadius get lgBorder => BorderRadius.circular(lg);
  static BorderRadius get xlBorder => BorderRadius.circular(xl);
  static BorderRadius get pillBorder => BorderRadius.circular(pill);
  static BorderRadius get bottomSheet =>
      BorderRadius.vertical(top: Radius.circular(xl));

  // Semantic aliases for intent-revealing usage
  static BorderRadius get cardBorder => mdBorder;
  static BorderRadius get searchBorder => pillBorder;
  static BorderRadius get chipBorder => pillBorder;
  static BorderRadius get buttonBorder => smBorder;
  static BorderRadius get dialogBorder => lgBorder;
}
