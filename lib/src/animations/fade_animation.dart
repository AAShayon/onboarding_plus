import 'package:flutter/material.dart';

class FadeAnimationWrapper extends StatefulWidget {
  final Widget child;

  const FadeAnimationWrapper({super.key, required this.child});

  @override
  State<FadeAnimationWrapper> createState() => _FadeAnimationWrapperState();
}

class _FadeAnimationWrapperState extends State<FadeAnimationWrapper>
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
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}