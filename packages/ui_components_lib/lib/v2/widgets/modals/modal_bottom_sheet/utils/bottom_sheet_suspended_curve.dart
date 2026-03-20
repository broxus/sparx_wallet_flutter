// ignore_for_file: prefer_asserts_with_message

import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

class BottomSheetSuspendedCurve extends Curve {
  const BottomSheetSuspendedCurve(
    this.startingPoint, {
    this.curve = Curves.easeOutCubic,
  });

  final double startingPoint;
  final Curve curve;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(startingPoint >= 0.0 && startingPoint <= 1.0);

    if (t < startingPoint) {
      return t;
    }

    if (t == 1.0) {
      return t;
    }

    final curveProgress = (t - startingPoint) / (1 - startingPoint);
    final transformed = curve.transform(curveProgress);
    return lerpDouble(startingPoint, 1, transformed)!;
  }

  @override
  String toString() {
    return '${describeIdentity(this)}($startingPoint, $curve)';
  }
}
