import 'package:flutter/material.dart';

class RotateAnimationWrapper extends StatefulWidget {
  final Widget child;

  const RotateAnimationWrapper({super.key, required this.child});

  @override
  State<RotateAnimationWrapper> createState() =>
      _RotateAnimationWrapperState();
}

class _RotateAnimationWrapperState extends State<RotateAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Rotate from 0 to 360 degrees
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}