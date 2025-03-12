import 'dart:math';

import 'package:app/feature/browserV2/screens/main/widgets/control_panel/tabs_list_control_panel.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';

class BrowserTabMenu extends StatefulWidget {
  const BrowserTabMenu._(this._data);

  final RenderData _data;

  static OverlayEntry? _entry;

  static void show(
    BuildContext context,
    RenderData data,
  ) {
    hide();
    _entry = OverlayEntry(
      builder: (_) {
        return Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: hide,
            child: BrowserTabMenu._(data),
          ),
        );
      },
    );
    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
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
