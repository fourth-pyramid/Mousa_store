import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousa_store/features/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

typedef OnboardingView = OnboardingPage;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
                OnboardingItem(
                  controller: _controller,
                  image: 'assets/on_boarding/on_boarding1.jpg',
                  title: localization.onboarding_title_1,
                  description: localization.onboarding_desc_1,
                  isLastPage: isLastPage,
                  localization: localization,
                  pageCount: 3,
                ),
                OnboardingItem(
                  controller: _controller,
                  image: 'assets/on_boarding/on_boarding2.jpg',
                  title: localization.onboarding_title_2,
                  description: localization.onboarding_desc_2,
                  isLastPage: isLastPage,
                  localization: localization,
                  pageCount: 3,
                ),
                OnboardingItem(
                  controller: _controller,
                  image: 'assets/on_boarding/on_boarding3.jpg',
                  title: localization.onboarding_title_3,
                  description: localization.onboarding_desc_3,
                  isLastPage: isLastPage,
                  localization: localization,
                  pageCount: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
