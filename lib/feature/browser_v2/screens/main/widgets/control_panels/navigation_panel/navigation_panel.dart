import 'dart:math';

import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/address_bar.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserNavigationPanel extends StatefulWidget {
  const BrowserNavigationPanel({
    required this.panelWidth,
    required this.urlWidth,
    required this.controller,
    required this.tabsState,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingCompleteUrl,
    required this.scrollModeState,
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
  final ListenableState<NavigationUrlPhysicMode> scrollModeState;

  @override
  State<BrowserNavigationPanel> createState() =>
      _BrowserTabViewMenuUrlPanelState();
}

class _BrowserTabViewMenuUrlPanelState extends State<BrowserNavigationPanel> {
  late final _physics = _SnapPageScrollPhysics(
    pageWidth: widget.urlWidth,
    modeState: widget.scrollModeState,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.panelWidth,
      height: BrowserNavigationPanel.height,
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
              return BrowserAddressBar(
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
  _SnapPageScrollPhysics({
    required this.pageWidth,
    required this.modeState,
    ScrollPhysics? parent,
  }) : super(parent: parent ?? const ClampingScrollPhysics()) {
    print('!!!');
  }

  final double pageWidth;
  final ListenableState<NavigationUrlPhysicMode> modeState;

  @override
  _SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapPageScrollPhysics(
      pageWidth: pageWidth,
      modeState: modeState,
      parent: buildParent(ancestor),
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if (!(modeState.value == NavigationUrlPhysicMode.none)) {
      final target = _getTargetPixels(position, velocity);
      return _InstantScrollSimulation(target);
    }

    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final target = _getTargetPixels(position, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: toleranceFor(position),
      );
    }
    return null;
  }

  double _getCurrentPage(ScrollMetrics position) {
    final offset = (position.viewportDimension - pageWidth) / 2;
    return (position.pixels + offset) / pageWidth;
  }

  double _getTargetPixels(ScrollMetrics position, double velocity) {
    final currentPage = _getCurrentPage(position);
    final tolerance = toleranceFor(position);
    double targetPage;

    if (velocity.abs() < tolerance.velocity) {
      targetPage = currentPage.roundToDouble();
    } else {
      targetPage = velocity > 0
          ? currentPage.ceilToDouble()
          : currentPage.floorToDouble();
    }

    final offset = (position.viewportDimension - pageWidth) / 2;
    final targetPixels = targetPage * pageWidth - offset;
    return max(
      position.minScrollExtent,
      min(
        targetPixels,
        position.maxScrollExtent,
      ),
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}

class _InstantScrollSimulation extends Simulation {
  _InstantScrollSimulation(this.target);

  final double target;

  @override
  double x(double time) => target;

  @override
  double dx(double time) => 0;

  @override
  bool isDone(double time) => true;
}

enum NavigationUrlPhysicMode {
  snap,
  none,
}
