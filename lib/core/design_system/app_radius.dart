import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// SPORTCORE Controlled Radius System
abstract class AppRadius {
  static double get xs => 6.r;
  static double get sm => 10.r;
  static double get md => 14.r;
  static double get lg => 20.r;
  static double get xl => 28.r;
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
}
