import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({required this.rate, this.size = 18, super.key});

  final double rate;
  final double size;

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(
      5,
      (index) => Icon(
        index < rate ? Icons.star : Icons.star_border,
        color: context.colors.secondary,
        size: size,
      ),
    ),
  );
}
