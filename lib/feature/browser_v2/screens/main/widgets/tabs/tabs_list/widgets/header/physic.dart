import 'dart:math';

import 'package:flutter/widgets.dart';

class CenterSnapScrollPhysics extends ClampingScrollPhysics {
  const CenterSnapScrollPhysics({
    required this.itemWidth,
    super.parent,
  });

  final double itemWidth;

  @override
  CenterSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CenterSnapScrollPhysics(
      itemWidth: itemWidth,
      parent: buildParent(ancestor),
    );
  }

  static const SpringDescription _spring = SpringDescription(
    mass: 1,
    stiffness: 60,
    damping: 20,
  );

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final current = position.pixels;
    final tol = toleranceFor(position);

    final target = _getTargetPixels(position);

    if ((target - current).abs() <= tol.distance) {
      return null;
    }

    return ScrollSpringSimulation(
      _spring,
      current,
      target,
      0,
      tolerance: tol,
    );
  }

  double _getCurrentPage(ScrollMetrics position) {
    final offset = (position.viewportDimension - itemWidth) / 2;
    return (position.pixels + offset) / itemWidth;
  }

  double _getTargetPixels(ScrollMetrics position) {
    final currentPage = _getCurrentPage(position);
    final targetPage = currentPage.roundToDouble();
    final offset = (position.viewportDimension - itemWidth) / 2;
    final pixels = targetPage * itemWidth - offset;
    return max(
      position.minScrollExtent,
      min(position.maxScrollExtent, pixels),
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}
