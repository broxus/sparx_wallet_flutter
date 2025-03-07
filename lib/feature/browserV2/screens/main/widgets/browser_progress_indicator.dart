import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserProgressIndicator extends StatefulWidget {
  const BrowserProgressIndicator({
    required this.animation,
    super.key,
  });

  final Animation<double> animation;

  @override
  State<BrowserProgressIndicator> createState() =>
      _BrowserProgressIndicatorState();
}

class _BrowserProgressIndicatorState extends State<BrowserProgressIndicator> {
  late final _painter = CoderPainter(
    widget.animation,
    ColorsResV2.p75,
  );

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _painter,
      ),
    );
  }
}

class CoderPainter extends CustomPainter {
  CoderPainter(
    this.animation,
    Color _color,
  )   : _paint = Paint()
          ..color = _color
          ..strokeWidth = 3,
        super(repaint: animation);

  final Animation<double> animation;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset.zero,
      Offset(
        animation.value == 1 ? 0 : size.width * animation.value,
        0,
      ),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CoderPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value;
  }
}
