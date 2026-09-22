import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(child: Divider(color: context.colors.border)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              context.l10n.or_sign_in_with_text,
              style: context.typography.caption.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
          Expanded(child: Divider(color: context.colors.border)),
        ],
      ),
      SizedBox(height: 16.h),
      SizedBox(
        width: double.infinity,
        height: 52.h,
        child: OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: context.colors.surface,
            foregroundColor: context.colors.textPrimary,
            side: BorderSide(color: context.colors.border),
            shape: RoundedRectangleBorder(
              borderRadius: context.radius.mdBorder,
            ),
            elevation: 0,
          ),
          icon: AppImage.asset(
            'assets/images/google_button.png',
            height: 22.h,
            width: 22.w,
          ),
          label: Text(
            'Google',
            style: context.typography.labelLarge.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
  );
}
