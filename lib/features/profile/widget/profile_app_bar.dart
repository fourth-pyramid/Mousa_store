import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/auth/auth_view.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return ListenableBuilder(
      listenable: authService,
      builder: (context, child) {
        final isLoggedIn = authService.isLoggedIn;
        final user = authService.user;
        final userName = user != null ? '${user.firstName} ${user.lastName}' : '';

        return Row(
          children: [
            AppImage.asset(
              'assets/images/mousa_store.png',
              height: 60,
              color: context.colors.textPrimary == Colors.white ? Colors.white : null,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            if (isLoggedIn)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.welcome_text.toUpperCase(),
                    style: context.typography.caption.copyWith(color: context.colors.textSecondary),
                  ),
                  if (user != null)
                    Text(
                      userName,
                      style: context.typography.labelLarge.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              )
            else
              GestureDetector(
                onTap: () {
                  unawaited(
                    navigateWithTransition<void>(context, const AuthView(), type: TransitionType.fade, replace: true),
                  );
                },
                child: Text(
                  context.l10n.auth_login.toUpperCase(),
                  style: context.typography.labelLarge.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
