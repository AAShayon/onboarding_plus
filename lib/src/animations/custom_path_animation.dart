import 'package:flutter/material.dart';

class CustomPathAnimationWrapper extends StatefulWidget {
  final Widget child;

  const CustomPathAnimationWrapper({super.key, required this.child});

  @override
  State<CustomPathAnimationWrapper> createState() =>
      _CustomPathAnimationWrapperState();
}

class _CustomPathAnimationWrapperState
    extends State<CustomPathAnimationWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Define a custom path animation (e.g., curve from bottom-left to top-right)
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 1.0), // Bottom-left
      end: const Offset(0.0, 0.0),   // Center
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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