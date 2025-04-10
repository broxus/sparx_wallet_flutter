import 'dart:async';

import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_menu/data.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<BrowserTabMenuItemData?> showBrowserTabMenu(
  BuildContext context,
  RenderData data,
) {
  return showDialog<BrowserTabMenuItemData?>(
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
            onItemPressed: (BrowserTabMenuItemData item) =>
                Navigator.of(context, rootNavigator: true).pop(item),
          ),
        ),
      );
    },
  );
}

class BrowserTabMenu extends StatefulWidget {
  const BrowserTabMenu._(
    this._data, {
    required this.onItemPressed,
  });

  final RenderData _data;
  final ValueChanged<BrowserTabMenuItemData> onItemPressed;

  @override
  State<BrowserTabMenu> createState() => _BrowserTabMenuState();
}

class _BrowserTabMenuState extends State<BrowserTabMenu> {
  late final _data = widget._data;

  // TODO(knightforce): temp
  // final _items = BrowserTabMenuItemData.values;
  final _items = [
    BrowserTabMenuItemData.copyLink,
    BrowserTabMenuItemData.bookmark,
  ];

  final _width = DimensSizeV2.d207;
  final _itemHeight = DimensSizeV2.d44;

  late final _menuHeight = _items.length * _itemHeight;
  final _margin = 8;

  late final _screenSize = MediaQuery.of(context).size;

  late final _xMax = _screenSize.width;
  late final _yMax = _screenSize.height -
      Toolbar.height -
      CustomBottomNavigationBar.height -
      _margin;

  double get _top {
    if ((_yMax - _data.yBottom - _menuHeight) > 0) {
      return _data.yBottom + _margin;
    }

    return _data.yTop - _margin - _menuHeight;
  }

  double get _left {
    if (_data.xLeft + _width < _xMax) {
      return _data.xLeft;
    }

    return _data.xRight - _width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: ColoredBox(
            color: Colors.transparent,
            child: SizedBox(
              width: _width,
              height: _menuHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(
                    DimensRadiusV2.radius16,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final item in _items)
                      _Item(
                        key: ValueKey(item),
                        title: item.title,
                        icon: item.icon,
                        onTap: () => widget.onItemPressed(item),
                        isShowBorder: !item.isLast,
                      ),
                  ],
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

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isShowBorder,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isShowBorder;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: DimensSizeV2.d44,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: isShowBorder
                ? Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(.1),
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textStyles.labelMedium
                      .copyWith(color: theme.colors.content2),
                ),
                Icon(
                  icon,
                  size: DimensSizeV2.d16,
                  color: theme.colors.content2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
