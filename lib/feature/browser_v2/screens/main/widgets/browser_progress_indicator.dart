import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/host_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/page_control_panel.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserProgressIndicator extends StatefulWidget {
  const BrowserProgressIndicator({
    required this.animation,
    required this.menuState,
    super.key,
  });

  final Animation<double> animation;
  final ListenableState<MenuType> menuState;

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
    return StateNotifierBuilder(
      listenableState: widget.menuState,
      builder: (_, MenuType? type) {
        return Transform.translate(
          offset: Offset(
            0,
            switch (type) {
              MenuType.view => -BrowserPageControlPanel.minHeight,
              MenuType.url => -HostPanel.height,
              _ => 500,
            },
          ),
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _painter,
            ),
          ),
        );
      },
    );
  }
}

class CoderPainter extends CustomPainter {
  CoderPainter(
    this.animation,
    Color _color,
  ) : super(repaint: animation) {
    _paint.color = _color;
  }

  final Animation<double> animation;
  static final _paint = Paint()..strokeWidth = 3;

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
