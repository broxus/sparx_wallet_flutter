import 'package:flutter/material.dart';

class MenuAnimation extends StatelessWidget {
  const MenuAnimation({
    required this.child,
    required this.controller,
    required this.offsetAnimation,
    required this.opacityAnimation,
    super.key,
  });

  final Animation<double> controller;
  final Animation<Offset> offsetAnimation;

  final Animation<double> opacityAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: child,
        ),
      ),
    );
  }
}
