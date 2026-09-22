import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

enum AppButtonVariant { primary, secondary, accent, outline, ghost }

class AppButton extends StatefulWidget {
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
    this.borderRadius,
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
  final BorderRadius? borderRadius;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      value: 1.0,
    );
    _scaleAnimation = _scaleController;
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.reverse();
    }
  }

  void _onTapUp(_) => _scaleController.forward();
  void _onTapCancel() => _scaleController.forward();

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    var border = BorderSide.none;
    var shadows = <BoxShadow>[];

    switch (widget.variant) {
      case AppButtonVariant.primary:
        bg = widget.backgroundColor ?? context.colors.secondary;
        fg = widget.textColor ?? context.colors.onSecondary;
        shadows = AppShadows.accentGlow;
        break;
      case AppButtonVariant.secondary:
        bg = widget.backgroundColor ?? context.colors.surfaceStrong;
        fg = widget.textColor ?? context.colors.textPrimary;
        shadows = AppShadows.subtle;
        break;
      case AppButtonVariant.accent:
        bg = widget.backgroundColor ?? context.colors.accent;
        fg = widget.textColor ?? context.colors.onSecondary;
        shadows = AppShadows.accentGlow;
        break;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = widget.textColor ?? context.colors.textPrimary;
        border = BorderSide(color: context.colors.border, width: 1.5);
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = widget.textColor ?? context.colors.textPrimary;
        break;
    }

    final effectiveHeight =
        widget.height != null ? widget.height!.h : context.sizes.buttonHeight;

    final effectiveBorderRadius =
        widget.borderRadius ??
        (widget.variant == AppButtonVariant.primary ||
                widget.variant == AppButtonVariant.accent
            ? context.radius.smBorder
            : context.radius.smBorder);

    final Widget child = widget.isLoading
        ? SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.text.isNotEmpty)
                Text(
                  widget.text.toUpperCase(),
                  style: context.typography.labelLarge.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              if (widget.icon != null) ...[
                if (widget.text.isNotEmpty) SizedBox(width: 8.w),
                widget.icon!,
              ],
            ],
          );

    final hasContent = widget.text.isNotEmpty || widget.icon != null;
    final effectiveWidth =
        widget.width != null && widget.width != double.infinity
            ? widget.width!.w
            : widget.width;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.isFullWidth
              ? (effectiveWidth ?? double.infinity)
              : effectiveWidth,
          height: effectiveHeight,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: effectiveBorderRadius,
            border: border != BorderSide.none ? Border.fromBorderSide(border) : null,
            boxShadow: widget.onPressed != null ? shadows : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: effectiveBorderRadius,
              splashColor: fg.withValues(alpha: 0.08),
              highlightColor: fg.withValues(alpha: 0.05),
              child: Center(child: hasContent ? child : const SizedBox.shrink()),
            ),
          ),
        ),
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
    this.borderRadius = 12.0,
    this.height = 50.0,
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
