import 'package:flutter/material.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';

class CustomFadeButton extends StatelessWidget {
  const CustomFadeButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 10.0,
    this.height = 52.0,
    this.width = double.infinity,
    this.icon,
    this.controller,
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final Widget? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => AppButton(
    text: text,
    onPressed: onPressed,
    variant: AppButtonVariant.outline,
    height: height,
    width: width == double.infinity ? null : width,
    isFullWidth: width == double.infinity,
    icon: icon,
  );
}
