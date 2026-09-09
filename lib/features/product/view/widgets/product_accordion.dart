import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class ProductAccordion extends StatefulWidget {
  const ProductAccordion({
    required this.title,
    required this.child,
    super.key,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget child;
  final bool initiallyExpanded;

  @override
  State<ProductAccordion> createState() => _ProductAccordionState();
}

class _ProductAccordionState extends State<ProductAccordion>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<bool> _isExpandedNotifier;

  @override
  void initState() {
    super.initState();
    _isExpandedNotifier = ValueNotifier<bool>(widget.initiallyExpanded);
  }

  @override
  void dispose() {
    _isExpandedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
    child: DecoratedBox(
      decoration: BoxDecoration(borderRadius: context.radius.smBorder),
      child: ValueListenableBuilder<bool>(
        valueListenable: _isExpandedNotifier,
        builder: (context, isExpanded, _) => Column(
          children: [
            InkWell(
              borderRadius: context.radius.smBorder,
              onTap: () {
                _isExpandedNotifier.value = !_isExpandedNotifier.value;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: context.typography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: context.durations.fast,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AnimatedCrossFade(
              duration: context.durations.normal,
              crossFadeState: isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: widget.child,
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    ),
  );
}
