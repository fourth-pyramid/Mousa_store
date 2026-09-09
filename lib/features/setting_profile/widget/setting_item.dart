import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    required this.title,
    required this.subtitle,
    this.image,
    super.key,
    this.onTap,
    this.icon,
  });
  final String title;
  final String subtitle;
  final Image? image;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface,
    borderRadius: context.radius.smBorder,
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: context.radius.smBorder),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: icon != null
          ? Icon(icon, color: context.colors.textPrimary)
          : image,
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: context.colors.textSecondary,
      ),
      title: Text(
        title,
        style: context.typography.body.copyWith(
          color: context.colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: context.typography.bodySmall.copyWith(
          color: context.colors.textSecondary,
        ),
      ),
      onTap: onTap,
    ),
  );
}
