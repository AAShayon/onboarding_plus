import 'package:flutter/material.dart';

class SlideAnimationWrapper extends StatefulWidget {
  final Widget child;

  const SlideAnimationWrapper({super.key, required this.child});

  @override
  State<SlideAnimationWrapper> createState() => _SlideAnimationWrapperState();
}

class _SlideAnimationWrapperState extends State<SlideAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Slide from bottom to center
    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // Bottom
      end: Offset.zero,          // Center
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}