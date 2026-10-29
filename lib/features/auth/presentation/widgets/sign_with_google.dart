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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        height: 52,
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
          icon: const AppImage.asset(
            'assets/images/google_button.png',
            height: 22,
            width: 22,
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
