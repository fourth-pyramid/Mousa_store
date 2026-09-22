import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';

// ponytail: reusable animated empty state widget with floating glow and smooth entrance
class AppEmptyState extends StatefulWidget {
  const AppEmptyState({
    required this.title,
    super.key,
    this.description,
    this.actionLabel,
    this.onActionTap,
    this.secondaryActionLabel,
    this.onSecondaryActionTap,
    this.icon,
    this.iconWidget,
    this.iconColor,
    this.badgeColor,
    this.padding,
  });

  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryActionTap;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;
  final Color? badgeColor;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppEmptyState> createState() => _AppEmptyStateState();
}

class _AppEmptyStateState extends State<AppEmptyState>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _entranceController;

  late final Animation<double> _floatAnimation;
  late final Animation<double> _pulseScaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    unawaited(_pulseController.repeat(reverse: true));

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _floatAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pulseScaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );

    unawaited(_entranceController.forward());
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.iconColor ?? context.colors.primary;

    return Padding(
      padding: widget.padding ?? EdgeInsets.all(context.spacing.xl),
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer glowing ring
                        Transform.scale(
                          scale: _pulseScaleAnimation.value * 1.25,
                          child: Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withValues(alpha: 0.06),
                            ),
                          ),
                        ),
                        // Inner glowing ring
                        Transform.scale(
                          scale: _pulseScaleAnimation.value * 1.1,
                          child: Container(
                            width: 82.w,
                            height: 82.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withValues(alpha: 0.12),
                            ),
                          ),
                        ),
                        // Center badge
                        Container(
                          width: 68.w,
                          height: 68.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.badgeColor ?? context.colors.surface,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.18),
                                blurRadius: 18,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child:
                                widget.iconWidget ??
                                Icon(
                                  widget.icon ?? Icons.inbox_outlined,
                                  size: 34.w,
                                  color: primaryColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  widget.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: context.typography.h3.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.description != null &&
                    widget.description!.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    widget.description!,
                    textAlign: TextAlign.center,
                    style: context.typography.bodySmall.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
                if (widget.actionLabel != null &&
                    widget.onActionTap != null) ...[
                  SizedBox(height: 24.h),
                  AppButton(
                    text: widget.actionLabel!,
                    onPressed: widget.onActionTap,
                    isFullWidth: false,
                  ),
                ],
                if (widget.secondaryActionLabel != null &&
                    widget.onSecondaryActionTap != null) ...[
                  SizedBox(height: 12.h),
                  AppButton(
                    text: widget.secondaryActionLabel!,
                    onPressed: widget.onSecondaryActionTap,
                    variant: AppButtonVariant.outline,
                    isFullWidth: false,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
