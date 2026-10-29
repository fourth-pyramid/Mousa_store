import 'package:flutter/material.dart';

/// SPORTCORE Controlled Radius System — native logical pixels
abstract class AppRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double pill = 999;

  // Pre-built BorderRadius helpers
  static final BorderRadius xsBorder = BorderRadius.circular(xs);
  static final BorderRadius smBorder = BorderRadius.circular(sm);
  static final BorderRadius mdBorder = BorderRadius.circular(md);
  static final BorderRadius lgBorder = BorderRadius.circular(lg);
  static final BorderRadius xlBorder = BorderRadius.circular(xl);
  static final BorderRadius pillBorder = BorderRadius.circular(pill);
  static const BorderRadius bottomSheet = BorderRadius.vertical(
    top: Radius.circular(xl),
  );

  // Semantic aliases for intent-revealing usage
  static BorderRadius get cardBorder => mdBorder;
  static BorderRadius get searchBorder => pillBorder;
  static BorderRadius get chipBorder => pillBorder;
  static BorderRadius get buttonBorder => smBorder;
  static BorderRadius get dialogBorder => lgBorder;
}
