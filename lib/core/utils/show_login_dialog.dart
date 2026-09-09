import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/features/auth/auth_view.dart';

void showLoginDialog(BuildContext context) {
  unawaited(
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.l10n.login_alert_title,
          style: context.typography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.primary,
          ),
        ),
        content: Text(
          context.l10n.login_alert_message,
          style: context.typography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.cancel_text,
              style: context.typography.body.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              unawaited(
                navigateWithTransition<void>(context, const AuthView()),
              );
            },
            child: Text(
              context.l10n.login_button,
              style: context.typography.body.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: context.radius.mdBorder),
      ),
    ),
  );
}
