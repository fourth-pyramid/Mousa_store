import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.colors.primary;

    return Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: effectiveColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
