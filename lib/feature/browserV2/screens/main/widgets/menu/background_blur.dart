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
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ColoredBox(
          color: const Color.fromRGBO(30, 32, 58, 0.9),
          child: child,
        ),
      ),
    );
  }
}
