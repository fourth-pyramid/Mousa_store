import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousa_store/features/onboarding/widgets/on_boarding_page.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  final ValueNotifier<bool> _isLastPageNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _controller.dispose();
    _isLastPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isLastPageNotifier,
            builder: (context, isLastPage, _) => PageView(
              controller: _controller,
              onPageChanged: (index) {
                _isLastPageNotifier.value = index == 2;
              },
              children: [
                OnboardingPage(
                  controller: _controller,
                  image: 'assets/on_boarding/on_boarding1.jpg',
                  title: localization.onboarding_title_1,
                  description: localization.onboarding_desc_1,
                  isLastPage: isLastPage,
                  localization: localization,
                ),
                OnboardingPage(
                  controller: _controller,
                  image: 'assets/on_boarding/on_boarding2.jpg',
                  title: localization.onboarding_title_2,
                  description: localization.onboarding_desc_2,
                  isLastPage: isLastPage,
                  localization: localization,
                ),
                OnboardingPage(
                  controller: _controller,
                  image: 'assets/on_boarding/on_boarding3.jpg',
                  title: localization.onboarding_title_3,
                  description: localization.onboarding_desc_3,
                  isLastPage: isLastPage,
                  localization: localization,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
