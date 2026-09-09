import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.hint = 'Search products...',
    this.readOnly = false,
    this.autofocus = false,
    this.onClear,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final String hint;
  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    onTap: onTap,
    readOnly: readOnly,
    autofocus: autofocus,
    style: context.typography.body.copyWith(color: context.colors.textPrimary),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: context.typography.body.copyWith(
        color: context.colors.textSecondary,
      ),
      filled: true,
      fillColor: context.colors.surface,
      prefixIcon: Icon(
        Icons.search,
        color: context.colors.textSecondary,
        size: context.sizes.iconMd,
      ),
      suffixIcon: controller?.text.isNotEmpty ?? false
          ? IconButton(
              icon: Icon(
                Icons.close,
                color: context.colors.textSecondary,
                size: context.sizes.iconSm,
              ),
              onPressed: () {
                controller?.clear();
                onClear?.call();
              },
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: context.radius.smBorder,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: context.radius.smBorder,
        borderSide: BorderSide(color: context.colors.primary, width: 1.5),
      ),
    ),
  );
}
