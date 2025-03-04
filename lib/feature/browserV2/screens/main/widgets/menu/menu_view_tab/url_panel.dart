import 'dart:math';

import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabViewMenuUrlPanel extends StatefulWidget {
  const BrowserTabViewMenuUrlPanel({
    required this.height,
    required this.controller,
    required this.tabsState,
    required this.onEditingCompleteUrl,
    super.key,
  });

  final double height;
  final ScrollController controller;
  final ListenableState<BrowserTabsCollection> tabsState;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;

  @override
  State<BrowserTabViewMenuUrlPanel> createState() =>
      _BrowserTabViewMenuUrlPanelState();
}

class _BrowserTabViewMenuUrlPanelState
    extends State<BrowserTabViewMenuUrlPanel> {
  late final _screenSize = MediaQuery.of(context).size.width;
  late final _urlSize = _screenSize * .915;
  late final _physics = _SnapPageScrollPhysics(
    elementPadding: DimensSizeV2.d8,
    elementWidth: _urlSize,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _screenSize,
      height: widget.height,
      child: StateNotifierBuilder<BrowserTabsCollection>(
        listenableState: widget.tabsState,
        builder: (_, BrowserTabsCollection? data) {
          if (data == null) {
            return const SizedBox.shrink();
          }

          return ListView.separated(
            physics: _physics,
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d8,
            ),
            separatorBuilder: _buildSeparator,
            scrollDirection: Axis.horizontal,
            controller: widget.controller,
            itemCount: data.count,
            itemBuilder: (_, int index) {
              return _UrlAddressPanel(
                key: ValueKey(data.list[index].id),
                width: _urlSize,
                tab: data.list[index],
                onEditingComplete: widget.onEditingCompleteUrl,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSeparator(context, index) => const SizedBox(
        width: DimensSizeV2.d8,
      );
}

class _UrlAddressPanel extends StatefulWidget {
  const _UrlAddressPanel({
    required this.tab,
    required this.width,
    required this.onEditingComplete,
    super.key,
  });

  final BrowserTab tab;
  final double width;
  final DoubleValueCallback<String, String> onEditingComplete;

  @override
  State<_UrlAddressPanel> createState() => _UrlAddressPanelState();
}

class _UrlAddressPanelState extends State<_UrlAddressPanel> {
  late final _controller = TextEditingController(
    text: widget.tab.url.toString(),
  );

  @override
  void didUpdateWidget(covariant _UrlAddressPanel oldWidget) {
    if (oldWidget.tab.url != widget.tab.url) {
      _controller.text = widget.tab.url.toString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: DimensSizeV2.d40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.themeStyleV2.colors.backgroundInput,
        ),
        child: TextField(
          controller: _controller,
          onEditingComplete: _onEditingComplete,
        ),
      ),
    );
  }

  void _onEditingComplete() => widget.onEditingComplete(
        widget.tab.id,
        _controller.text,
      );
}

class _SnapPageScrollPhysics extends ScrollPhysics {
  const _SnapPageScrollPhysics({
    required this.elementWidth,
    required this.elementPadding,
    super.parent,
  });

  final double elementWidth;
  final double elementPadding;

  @override
  _SnapPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapPageScrollPhysics(
      parent: buildParent(ancestor),
      elementWidth: elementWidth,
      elementPadding: elementPadding,
    );
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    final pageWidth = elementWidth + elementPadding;
    final page = position.pixels / pageWidth + velocity / 3000;
    final offset = (position.viewportDimension - elementWidth) / 2;
    final target = page.roundToDouble() * pageWidth - offset + elementPadding;
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
