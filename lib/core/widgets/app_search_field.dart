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
  Widget build(BuildContext context) => Container(
    height: context.sizes.searchBarHeight,
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: context.radius.searchBorder,
      boxShadow: AppShadows.card,
      border: Border.all(color: context.colors.border, width: 0.5),
    ),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      readOnly: readOnly,
      autofocus: autofocus,
      style: context.typography.body.copyWith(
        color: context.colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.typography.body.copyWith(
          color: context.colors.textMuted,
        ),
        filled: false,
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(start: 14.w, end: 8.w),
          child: Icon(
            Icons.search_rounded,
            color: context.colors.textSecondary,
            size: context.sizes.iconLg,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 42.w,
          minHeight: 42.h,
        ),
        suffixIcon: controller?.text.isNotEmpty ?? false
            ? GestureDetector(
                onTap: () {
                  controller?.clear();
                  onClear?.call();
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: Icon(
                    Icons.cancel_rounded,
                    color: context.colors.textMuted,
                    size: context.sizes.iconMd,
                  ),
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 36.w,
          minHeight: 36.h,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}
