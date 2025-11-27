import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SystemSpace extends StatelessWidget {
  const SystemSpace({this.additionalPadding = 0, super.key});

  final double additionalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).systemGestureInsets.bottom + additionalPadding,
    );
  }
}

class SystemPadding extends StatelessWidget {
  const SystemPadding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).systemGestureInsets.bottom,
      ),
      child: child,
    );
  }
}

class KeyboardPadding extends StatelessWidget {
  const KeyboardPadding({required this.child, required this.bottom, super.key});

  final Widget child;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Padding(
          padding: EdgeInsets.only(bottom: isKeyboardVisible ? 0 : bottom),
          child: child,
        );
      },
    );
  }
}
