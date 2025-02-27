import 'dart:ui';

import 'package:flutter/material.dart';

class BrowserMenuBackgroundBlur extends StatelessWidget {
  const BrowserMenuBackgroundBlur({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: ColoredBox(
          color: Color.fromRGBO(30, 32, 58, 0.9),
          child: child,
        ),
      ),
    );
  }
}
