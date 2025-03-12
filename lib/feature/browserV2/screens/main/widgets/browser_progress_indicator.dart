import 'package:app/feature/browserV2/screens/main/data/menu_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/menu_tab_list.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/page_control_panel/page_control_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/url_text_panel.dart';
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
        // BrowserTabListMenu
        // BrowserTabViewMenu
        // MenuRawUrl
        return Transform.translate(
          offset: Offset(
            0,
            switch (type) {
              MenuType.list => -BrowserTabListMenu.height,
              MenuType.view => -BrowserPageControlPanel.minHeight,
              MenuType.url => -UrlTextPanel.height,
              _ => 300,
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
