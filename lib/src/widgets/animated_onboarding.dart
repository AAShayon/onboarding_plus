import 'package:flutter/material.dart';
import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';
import '../animations/zoom_animation.dart';
import '../animations/rotate_animation.dart';
import '../animations/custom_path_animation.dart';
import '../animations/custom_combine_animation.dart';
import '../config/onboarding_config.dart';
import '../config/onboarding_page.dart';

class AnimatedOnboarding extends StatefulWidget {
  final OnboardingConfig config;
  final VoidCallback onCompleted;

  const AnimatedOnboarding({
    super.key,
    required this.config,
    required this.onCompleted,
  });

  @override
  State<AnimatedOnboarding> createState() => _AnimatedOnboardingState();
}

class _AnimatedOnboardingState extends State<AnimatedOnboarding>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _buildAnimation(Widget child, OnboardingPage page) {
    switch (page.animationType) {
      case OnboardingAnimationType.fade:
        return FadeAnimationWrapper(child: child);
      case OnboardingAnimationType.slide:
        return SlideAnimationWrapper(child: child);
      case OnboardingAnimationType.zoom:
        return ZoomAnimationWrapper(child: child);
      case OnboardingAnimationType.rotate:
        return RotateAnimationWrapper(child: child);
      case OnboardingAnimationType.customPath:
        return CustomPathAnimationWrapper(child: child);
      case OnboardingAnimationType.customCombine:
        return CustomCombineAnimationWrapper(child: child);
      default:
        return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.config.pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final page = widget.config.pages[index];
              return _buildAnimation(
                _buildPageContent(page),
                page,
              );
            },
          ),
          // Add controls or indicators here
        ],
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    return Container(
      color: page.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200, width: 200, child: page.imageBuilder(context)),
            Text(page.title, style: const TextStyle(fontSize: 24)),
            Text(page.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}