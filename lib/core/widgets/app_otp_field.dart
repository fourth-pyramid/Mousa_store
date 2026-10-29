import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

/// An accessible, robust OTP/PIN input widget built with Flutter SDK components.
/// Uses a single transparent text field with custom rendered character boxes for
/// reliable paste, backspace, selection, and autofill behavior.
class AppOtpField extends StatefulWidget {
  const AppOtpField({
    this.length = 6,
    this.fieldWidth = 50,
    this.fieldHeight = 56,
    this.onChanged,
    this.onCompleted,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.style,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.isError = false,
    super.key,
  });

  final int length;
  final double fieldWidth;
  final double fieldHeight;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? style;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final bool isError;

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }

    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }

    _controller.addListener(_handleTextChanged);
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant AppOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _controller.dispose();
        _ownsController = false;
      }
      _controller = widget.controller ?? TextEditingController();
      _ownsController = widget.controller == null;
      _controller.addListener(_handleTextChanged);
    }
    if (oldWidget.focusNode != widget.focusNode) {
      if (_ownsFocusNode) {
        _focusNode.dispose();
        _ownsFocusNode = false;
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _ownsFocusNode = widget.focusNode == null;
      _focusNode.addListener(_handleFocusChanged);
    }
  }

  void _handleTextChanged() {
    final text = _controller.text;
    widget.onChanged?.call(text);
    if (text.length == widget.length) {
      widget.onCompleted?.call(text);
    }
    setState(() {});
  }

  void _handleFocusChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _focusNode.removeListener(_handleFocusChanged);
    if (_ownsController) {
      _controller.dispose();
    }
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = _controller.text;
    final effectiveRadius = widget.borderRadius ?? context.radius.mdBorder;
    final effectiveBorderColor = widget.isError
        ? context.colors.error
        : (widget.borderColor ?? context.colors.border);
    final effectiveFocusedBorderColor = widget.isError
        ? context.colors.error
        : (widget.focusedBorderColor ?? context.colors.primary);
    final effectiveBgColor = widget.backgroundColor ?? context.colors.surface;
    final effectiveTextStyle =
        widget.style ??
        context.typography.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colors.textPrimary,
        );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const minGap = 6.0;
          final availableWidth = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : widget.length * (widget.fieldWidth + minGap);
          final maxBoxWidth =
              (availableWidth - (widget.length - 1) * minGap) / widget.length;
          final effectiveBoxWidth = maxBoxWidth.clamp(36.0, widget.fieldWidth);

          return Stack(
            alignment: Alignment.center,
            children: [
              // ── Visual OTP Box Grid ──────────────────────────────────
              Semantics(
                label: 'OTP input with ${widget.length} digits',
                value: text,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(widget.length, (index) {
                    final isCurrent =
                        _focusNode.hasFocus &&
                        (index == text.length ||
                            (index == widget.length - 1 &&
                                text.length == widget.length));
                    final hasValue = index < text.length;
                    final char = hasValue ? text[index] : '';

                    return Container(
                      width: effectiveBoxWidth,
                      constraints: BoxConstraints(
                        minHeight: widget.fieldHeight,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: effectiveBgColor,
                        borderRadius: effectiveRadius,
                        border: Border.all(
                          color: isCurrent
                              ? effectiveFocusedBorderColor
                              : (hasValue
                                    ? effectiveFocusedBorderColor.withValues(
                                        alpha: 0.6,
                                      )
                                    : effectiveBorderColor),
                          width: isCurrent ? 2.0 : 1.2,
                        ),
                        boxShadow: isCurrent
                            ? [
                                BoxShadow(
                                  color: effectiveFocusedBorderColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(char, style: effectiveTextStyle),
                      ),
                    );
                  }),
                ),
              ),

              // ── Transparent Native TextField for interaction ─────────
              Positioned.fill(
                child: Opacity(
                  opacity: 0.0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: widget.autofocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    enableInteractiveSelection: true,
                    cursorWidth: 0,
                    cursorColor: Colors.transparent,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(widget.length),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
