import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/features/auth/auth_view.dart';
import 'package:mousa_store/l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.controller,
    required this.image,
    required this.title,
    required this.description,
    required this.isLastPage,
    required this.localization,
    required this.pageCount,
    super.key,
  });

  final PageController controller;
  final String image;
  final String title;
  final String description;
  final bool isLastPage;
  final AppLocalizations localization;
  final int pageCount;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      AppImage(image: image),
      // Multi-stop gradient — heavier at bottom for text readability
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.05),
              Colors.black.withValues(alpha: 0.35),
              Colors.black.withValues(alpha: 0.88),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
      SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page indicator
              SmoothPageIndicator(
                controller: controller,
                count: pageCount,
                effect: ExpandingDotsEffect(
                  dotHeight: 5.h,
                  dotWidth: 5.w,
                  expansionFactor: 5,
                  spacing: 5.w,
                  activeDotColor: AppColorTokens.accent,
                  dotColor: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              SizedBox(height: 20.h),

              // Title — large, bold, no uppercase forced
              Text(
                title,
                style: context.typography.h1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                description,
                style: context.typography.bodyLarge.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 36.h),

              if (isLastPage) ...[
                // Login button — white fill
                _OnboardingButton(
                  label: localization.login_button,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    unawaited(
                      navigateWithTransition<void>(
                        context,
                        const AuthView(),
                        replace: true,
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                // Register button — outline
                _OnboardingButton(
                  label: localization.sign_up_button,
                  backgroundColor: Colors.transparent,
                  textColor: Colors.white,
                  borderColor: Colors.white.withValues(alpha: 0.8),
                  onPressed: () {
                    unawaited(
                      navigateWithTransition<void>(
                        context,
                        const AuthView(startWithLogin: false),
                        replace: true,
                      ),
                    );
                  },
                ),
              ] else ...[
                _OnboardingButton(
                  label: localization.next_button,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    unawaited(
                      controller.nextPage(
                        duration: context.durations.normal,
                        curve: Curves.easeInOut,
                      ),
                    );
                  },
                ),
              ],
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    ],
  );
}

class _OnboardingButton extends StatelessWidget {
  const _OnboardingButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: context.sizes.buttonHeight,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: context.radius.smBorder,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.5)
            : null,
        boxShadow: backgroundColor == Colors.white ? AppShadows.float : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: context.radius.smBorder,
          splashColor: textColor.withValues(alpha: 0.1),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: context.typography.label.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
