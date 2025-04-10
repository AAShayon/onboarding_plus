import 'package:flutter/material.dart';

class CustomCombineAnimationWrapper extends StatefulWidget {
  final Widget child;

  const CustomCombineAnimationWrapper({super.key, required this.child});

  @override
  State<CustomCombineAnimationWrapper> createState() =>
      _CustomCombineAnimationWrapperState();
}

class _CustomCombineAnimationWrapperState
    extends State<CustomCombineAnimationWrapper> with TickerProviderStateMixin {
  late AnimationController _sunsetController;
  late Animation<double> _sunsetAnimation;

  @override
  void initState() {
    super.initState();

    _sunsetController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the sunset animation
    );

    _sunsetAnimation = CurvedAnimation(
      parent: _sunsetController,
      curve: Curves.easeInOut,
    );

    _sunsetController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sunsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -200 * (1 - _sunsetAnimation.value)), // Move vertically
          child: Opacity(
            opacity: _sunsetAnimation.value, // Fade in
            child: widget.child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _sunsetController.dispose();
    super.dispose();
  }
}