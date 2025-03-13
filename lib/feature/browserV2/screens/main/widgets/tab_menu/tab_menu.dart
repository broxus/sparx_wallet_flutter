import 'dart:async';

import 'package:app/feature/browserV2/screens/main/widgets/control_panel/tabs_list_control_panel.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';

class BrowserTabMenu extends StatefulWidget {
  const BrowserTabMenu._(
    this._data, {
    required this.onSelected,
  });

  final RenderData _data;
  final VoidCallback onSelected;

  static Future<void> show(
    BuildContext context,
    RenderData data,
  ) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (_) {
        return GestureDetector(
          onTap: () => Navigator.of(context, rootNavigator: true).pop(),
          child: CustomPaint(
            painter: _HolePainter(
              holeRect: Rect.fromLTRB(
                data.xLeft,
                data.yTop,
                data.xRight,
                data.yBottom,
              ),
            ),
            child: BrowserTabMenu._(
              data,
              onSelected: () =>
                  Navigator.of(context, rootNavigator: true).pop(),
            ),
          ),
        );
      },
    );
  }

  @override
  State<BrowserTabMenu> createState() => _BrowserTabMenuState();
}

class _BrowserTabMenuState extends State<BrowserTabMenu> {
  late final _data = widget._data;

  final _width = 207.0;
  final _height = 176.0;
  final _margin = 8;

  late final _screenSize = MediaQuery.of(context).size;

  late final _xMax = _screenSize.width;
  late final _yMax = _screenSize.height -
      BrowserTabsListControlPanel.height -
      CustomBottomNavigationBar.height -
      _margin;

  double get _top {
    if ((_yMax - _data.yBottom - _height) > 0) {
      return _data.yBottom + _margin;
    }

    return _data.yTop - _margin - _height;
  }

  double get _left {
    if (_data.xLeft + _width < _xMax) {
      return _data.xLeft;
    }

    return _data.xRight - _width;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: ColoredBox(
            color: Colors.transparent,
            child: SizedBox(
              width: _width,
              height: _height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HolePainter extends CustomPainter {
  _HolePainter({required this.holeRect});

  final Rect holeRect;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          holeRect,
          const Radius.circular(16),
        ),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
      path,
      Paint()..color = Colors.black54,
    );
  }

  @override
  bool shouldRepaint(covariant _HolePainter oldDelegate) {
    return false;
  }
}
