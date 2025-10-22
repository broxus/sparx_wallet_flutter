import 'dart:ui';

import 'package:flutter/material.dart';

class BrowserMenuBackgroundBlur extends StatelessWidget {
  const BrowserMenuBackgroundBlur({
    required this.child,
    required this.blurHeight,
    super.key,
  });

  final Widget child;
  final double blurHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ColoredBox(
              color: const Color.fromRGBO(30, 32, 58, 0.9),
              child: SizedBox(width: double.infinity, height: blurHeight),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
