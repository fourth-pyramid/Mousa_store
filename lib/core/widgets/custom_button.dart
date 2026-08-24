import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

enum AppButtonVariant { primary, secondary, accent, outline, ghost }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    var border = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = backgroundColor ?? context.colors.secondary;
        fg = textColor ?? context.colors.onSecondary;
        break;
      case AppButtonVariant.secondary:
        bg = backgroundColor ?? context.colors.surfaceStrong;
        fg = textColor ?? context.colors.textPrimary;
        break;
      case AppButtonVariant.accent:
        bg = backgroundColor ?? context.colors.accent;
        fg = textColor ?? context.colors.onSecondary;
        break;
      case AppButtonVariant.outline:
        bg = context.colors.transparent;
        fg = textColor ?? context.colors.textPrimary;
        border = BorderSide(color: context.colors.border, width: 1.5);
        break;
      case AppButtonVariant.ghost:
        bg = context.colors.transparent;
        fg = textColor ?? context.colors.textPrimary;
        break;
    }

    final effectiveHeight = height != null ? height!.h : context.sizes.buttonHeight;

    final Widget child = isLoading
        ? SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(fg)),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (text.isNotEmpty)
                Text(
                  text.toUpperCase(),
                  style: context.typography.labelLarge.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (icon != null) ...[if (text.isNotEmpty) SizedBox(width: 8.w), icon!],
            ],
          );

    final hasContent = text.isNotEmpty || icon != null;
    final effectiveWidth = width != null && width != double.infinity ? width!.w : width;

    return SizedBox(
      width: isFullWidth ? (effectiveWidth ?? double.infinity) : effectiveWidth,
      height: effectiveHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          side: border,
          shape: RoundedRectangleBorder(borderRadius: context.radius.mdBorder),
          padding: EdgeInsets.symmetric(horizontal: text.isNotEmpty ? 24.w : 12.w),
        ),
        onPressed: isLoading ? null : onPressed,
        child: hasContent ? child : const SizedBox.shrink(),
      ),
    );
  }
}

/// Helper button wrapper
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.onPressed,
    super.key,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 10.0,
    this.height = 52.0,
    this.width = double.infinity,
    this.icon,
    this.controller,
    this.isLoading = false,
  });

  final Widget text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double height;
  final double width;
  final Widget? icon;
  final TextEditingController? controller;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var label = '';
    var iconWidget = icon;
    if (text is Text) {
      label = (text as Text).data ?? '';
    } else {
      iconWidget ??= text;
    }

    return AppButton(
      text: label,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? context.colors.accent,
      textColor: textColor ?? context.colors.onSecondary,
      height: height,
      width: width == double.infinity ? null : width,
      isFullWidth: width == double.infinity,
      icon: iconWidget,
      isLoading: isLoading,
    );
  }
}
