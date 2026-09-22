import 'package:flutter/material.dart';

/// SPORTCORE Semantic Shadow Tokens
abstract class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Layered shadow for cards
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.04),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
  ];

  /// Lifted card shadow
  static const List<BoxShadow> cardLifted = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 28,
      offset: Offset(0, 12),
    ),
  ];

  /// Dark mode card subtle shadow
  static const List<BoxShadow> cardDark = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.35),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  /// Layered shadow for navigation
  static const List<BoxShadow> nav = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      blurRadius: 14,
      offset: Offset(0, -3),
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      blurRadius: 28,
      offset: Offset(0, 8),
    ),
  ];
  static const List<BoxShadow> navigation = nav;

  /// Layered shadow for floating elements
  static const List<BoxShadow> float = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 32,
      offset: Offset(0, 12),
    ),
  ];
  static const List<BoxShadow> floating = float;

  /// Red accent glow for buttons / indicators
  static const List<BoxShadow> accentGlow = [
    BoxShadow(
      color: Color.fromRGBO(230, 46, 45, 0.35),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];
}
