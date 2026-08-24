import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_image.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
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
    super.key,
  });
  final PageController controller;
  final String image;
  final String title;
  final String description;
  final bool isLastPage;
  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) => Stack(
      fit: StackFit.expand,
      children: [
        AppImage(image: image),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isLastPage) ...[
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 4,
                      dotWidth: 24,
                      expansionFactor: 2,
                      activeDotColor: Colors.white,
                      dotColor: Color(0x66FFFFFF),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                Text(
                  title.toUpperCase(),
                  style: context.typography.h2.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  description,
                  style: context.typography.body.copyWith(
                    color: const Color(0xCCFFFFFF),
                  ),
                ),
                SizedBox(height: 32.h),

                if (isLastPage) ...[
                  AppButton(
                    onPressed: () {
                      unawaited(
                        navigateWithTransition<void>(
                          context,
                          const AuthView(),
                          replace: true,
                        ),
                      );
                    },
                    text: localization.login_button,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 12.h),
                  AppButton(
                    onPressed: () {
                      unawaited(
                        navigateWithTransition<void>(
                          context,
                          const AuthView(startWithLogin: false),
                          replace: true,
                        ),
                      );
                    },
                    text: localization.sign_up_button,
                    variant: AppButtonVariant.outline,
                    textColor: Colors.white,
                  ),
                ] else ...[
                  AppButton(
                    onPressed: () {
                      unawaited(
                        controller.nextPage(
                          duration: context.durations.normal,
                          curve: Curves.easeInOut,
                        ),
                      );
                    },
                    text: localization.next_button,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
}
