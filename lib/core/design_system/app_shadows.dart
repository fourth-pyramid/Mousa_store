import 'package:flutter/material.dart';

/// SPORTCORE Subtle Shadow Tokens
abstract class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
}
