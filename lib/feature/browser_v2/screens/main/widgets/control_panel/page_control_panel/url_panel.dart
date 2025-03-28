import 'dart:math';

import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panel/page_control_panel/url_field.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabViewMenuUrlPanel extends StatefulWidget {
  const BrowserTabViewMenuUrlPanel({
    required this.panelWidth,
    required this.urlWidth,
    required this.controller,
    required this.tabsState,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingCompleteUrl,
    super.key,
  });

  static const height = DimensSizeV2.d48;

  final double panelWidth;
  final double urlWidth;
  final ScrollController controller;
  final ListenableState<BrowserTabsCollection> tabsState;
  final ValueChanged<String> onPressedCurrentUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;

  @override
  State<BrowserTabViewMenuUrlPanel> createState() =>
      _BrowserTabViewMenuUrlPanelState();
}

class _BrowserTabViewMenuUrlPanelState
    extends State<BrowserTabViewMenuUrlPanel> {
  late final _physics = _SnapPageScrollPhysics(
    elementWidth: widget.urlWidth,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.panelWidth,
      height: BrowserTabViewMenuUrlPanel.height,
      child: StateNotifierBuilder<BrowserTabsCollection>(
        listenableState: widget.tabsState,
        builder: (_, BrowserTabsCollection? data) {
          if (data == null) {
            return const SizedBox.shrink();
          }

          return ListView.builder(
            padding: data.count == 1
                ? const EdgeInsets.only(left: DimensSizeV2.d8)
                : EdgeInsets.zero,
            physics: _physics,
            scrollDirection: Axis.horizontal,
            controller: widget.controller,
            itemCount: data.count,
            itemBuilder: (_, int index) {
              return UrlField(
                key: ValueKey(data.list[index].id),
                width: widget.urlWidth,
                tab: data.list[index],
                onPressedCurrentUrlMenu: widget.onPressedCurrentUrlMenu,
                onPressedRefresh: widget.onPressedRefresh,
                onEditingComplete: widget.onEditingCompleteUrl,
              );
            },
          );
        },
      ),
    );
  }
}

class _SnapPageScrollPhysics extends ScrollPhysics {
  const _SnapPageScrollPhysics({
    required this.elementWidth,
    super.parent,
  });

  final double elementWidth;

  @override
  _SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapPageScrollPhysics(
      parent: buildParent(ancestor),
      elementWidth: elementWidth,
    );
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    final pageWidth = elementWidth;
    final page = position.pixels / pageWidth + velocity / 3000;
    final offset = (position.viewportDimension - elementWidth) / 2;
    final target = page.roundToDouble() * pageWidth - offset;
    return max(0, min(target, position.maxScrollExtent));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = toleranceFor(position);
    final target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
