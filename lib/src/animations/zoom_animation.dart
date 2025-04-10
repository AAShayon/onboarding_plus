import 'package:flutter/material.dart';

class ZoomAnimationWrapper extends StatefulWidget {
  final Widget child;

  const ZoomAnimationWrapper({super.key, required this.child});

  @override
  State<ZoomAnimationWrapper> createState() => _ZoomAnimationWrapperState();
}

class _ZoomAnimationWrapperState extends State<ZoomAnimationWrapper>
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

    // Scale from 0 to 1
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}