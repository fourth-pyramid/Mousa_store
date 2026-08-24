import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.size = 44,
    this.backgroundColor,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? context.colors.surface;
    final fg = iconColor ?? context.colors.textPrimary;

    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: bg,
          shape: RoundedRectangleBorder(borderRadius: context.radius.smBorder),
        ),
        icon: Icon(icon, color: fg, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
