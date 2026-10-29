import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class ProductAccordion extends StatefulWidget {
  const ProductAccordion({
    required this.title,
    required this.child,
    super.key,
    this.initiallyExpanded = true,
    this.icon,
  });

  final String title;
  final Widget child;
  final bool initiallyExpanded;
  final IconData? icon;

  @override
  State<ProductAccordion> createState() => _ProductAccordionState();
}

class _ProductAccordionState extends State<ProductAccordion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _expandAnimation;
  late final ValueNotifier<bool> _isExpandedNotifier;

  @override
  void initState() {
    super.initState();
    _isExpandedNotifier = ValueNotifier<bool>(widget.initiallyExpanded);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      value: widget.initiallyExpanded ? 1.0 : 0.0,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _isExpandedNotifier.dispose();
    super.dispose();
  }

  void _toggle() {
    final expanded = !_isExpandedNotifier.value;
    _isExpandedNotifier.value = expanded;
    if (expanded) {
      _animController.forward();
    } else {
      _animController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: context.radius.mdBorder,
        border: Border.all(color: context.colors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: context.radius.mdBorder,
        child: ValueListenableBuilder<bool>(
          valueListenable: _isExpandedNotifier,
          builder: (context, isExpanded, _) => Column(
            children: [
              // ── Header ──────────────────────────────────────────
              InkWell(
                borderRadius: context.radius.mdBorder,
                onTap: _toggle,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left accent bar
                      AnimatedContainer(
                        duration: context.durations.fast,
                        width: 3.5,
                        decoration: BoxDecoration(
                          color: isExpanded
                              ? context.colors.accent
                              : context.colors.border,
                        ),
                      ),

                      // Title area
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              if (widget.icon != null) ...[
                                Icon(
                                  widget.icon,
                                  size: 18,
                                  color: isExpanded
                                      ? context.colors.accent
                                      : context.colors.textSecondary,
                                ),
                                const SizedBox(width: 10),
                              ],
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: context.typography.titleMedium
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colors.textPrimary,
                                      ),
                                ),
                              ),

                              // Chevron
                              AnimatedRotation(
                                turns: isExpanded ? 0.5 : 0,
                                duration: context.durations.normal,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isExpanded
                                        ? context.colors.accent.withValues(
                                            alpha: 0.1,
                                          )
                                        : context.colors.surfaceStrong,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18,
                                    color: isExpanded
                                        ? context.colors.accent
                                        : context.colors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Expandable Body ──────────────────────────────────
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 1,
                      color: context.colors.border.withValues(alpha: 0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
