import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title,
    this.message,
    this.onRetry,
  });

  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(context.spacing.xl),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.w,
              color: context.colors.error,
            ),
            SizedBox(height: 16.h),
            Text(
              title ?? context.l10n.something_went_wrong_text,
              textAlign: TextAlign.center,
              style: context.typography.h3.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message ?? context.l10n.could_not_load_content_text,
              textAlign: TextAlign.center,
              style: context.typography.bodySmall.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              AppButton(
                text: context.l10n.try_again_text,
                onPressed: onRetry,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
}
