import 'onboarding_page.dart';

class OnboardingConfig {
  final List<OnboardingPage> pages;
  final Duration animationDuration;
  final bool showSkipButton;
  final bool showDoneButton;
  final bool showProgressIndicator;

  const OnboardingConfig({
    required this.pages,
    this.animationDuration = const Duration(milliseconds: 500),
    this.showSkipButton = true,
    this.showDoneButton = true,
    this.showProgressIndicator = true,
  });
}

enum OnboardingAnimationType {
  fade,
  slide,
  zoom,
  rotate,
  customPath,
  combination,
  customCombine,
}

