import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserProgressIndicator extends StatefulWidget {
  const BrowserProgressIndicator({
    required this.indicatorState,
    super.key,
  });

  final ListenableState<double?> indicatorState;

  @override
  State<BrowserProgressIndicator> createState() =>
      _BrowserProgressIndicatorState();
}

class _BrowserProgressIndicatorState extends State<BrowserProgressIndicator> {
  late final _painter = CoderPainter(
    widget.indicatorState,
    context.themeStyleV2.colors.content3,
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
    );
  }
}

class CoderPainter extends CustomPainter {
  CoderPainter(
    this._progressState,
    this._color,
  ) : super(repaint: _progressState);

  final ListenableState<double?> _progressState;
  final Color _color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset.zero,
      Offset(
        size.width * (_progressState.value ?? 0),
        0,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return _progressState.value != null;
  }
}
