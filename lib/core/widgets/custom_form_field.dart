import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      if (label != null) ...[
        Text(
          label!.toUpperCase(),
          style: context.typography.labelMedium.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        SizedBox(height: 6.h),
      ],
      TextFormField(
        focusNode: focusNode,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxLines,
        onTap: onTap,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        validator: validator,
        style: context.typography.body.copyWith(
          color: context.colors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: context.typography.body.copyWith(
            color: context.colors.textSecondary,
          ),
          filled: true,
          fillColor: context.colors.surface,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 16.h,
          ),
          border: OutlineInputBorder(
            borderRadius: context.radius.mdBorder,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: context.radius.mdBorder,
            borderSide: BorderSide(color: context.colors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: context.radius.mdBorder,
            borderSide: BorderSide(color: context.colors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: context.radius.mdBorder,
            borderSide: BorderSide(color: context.colors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: context.radius.mdBorder,
            borderSide: BorderSide(color: context.colors.error, width: 1.5),
          ),
        ),
      ),
    ],
  );
}

/// Helper wrapper for CustomFormField
class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) => AppTextField(
    controller: controller,
    focusNode: focusNode,
    label: label,
    hint: hint ?? label,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    validator:
        validator ??
        ((value) {
          if (value == null || value.trim().isEmpty) {
            return context.l10n.required_field_text;
          }
          return null;
        }),
    onChanged: onChanged,
    onTap: onTap,
    keyboardType: keyboardType,
    obscureText: obscureText,
    readOnly: readOnly,
    inputFormatters: inputFormatters,
  );
}
