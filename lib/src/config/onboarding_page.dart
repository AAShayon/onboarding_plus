import 'package:flutter/material.dart';
import 'onboarding_config.dart';
class OnboardingPage {
  final WidgetBuilder imageBuilder; // Use a builder for flexible image options
  final String title;
  final String description;
  final Color backgroundColor;
  final OnboardingAnimationType animationType;

  const OnboardingPage({
    required this.imageBuilder,
    required this.title,
    required this.description,
    this.backgroundColor = Colors.white,
    this.animationType = OnboardingAnimationType.fade, // Default animation type
  });
}