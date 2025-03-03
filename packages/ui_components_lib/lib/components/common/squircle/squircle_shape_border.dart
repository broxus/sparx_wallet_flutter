// FROM https://github.com/flutter/flutter/pull/27523

// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: long-method, no-magic-number, double-literal-format
// ignore_for_file: binary-expression-operand-order, no-empty-block

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Shape border that implements figma's squircle.
/// https://github.com/aloisdeniel/figma_squircle/issues/5
class SquircleShapeBorder extends ShapeBorder {
  /// Creates a continuous cornered rectangle border.
  ///
  /// The [cornerRadius] argument must not be null.
  const SquircleShapeBorder({
    this.cornerRadius = 0.0,
    this.borderWidth = 1.0,
    this.borderColor,
  });

  /// The radius for each corner.
  ///
  /// The radius will be clamped to 0 if a value less than 0 is entered as the
  /// radius. By default the radius is 0. This value must not be null.
  ///
  /// Unlike [RoundedRectangleBorder], there is only a single radius value used
  /// to describe the radius for every corner.
  final double cornerRadius;
  final double borderWidth;
  final Color? borderColor;

  Path path(Rect rect) {
    final calculatedCornerRadius = cornerRadius;

    var limitedRadius = 0.0;
    final width = rect.width;
    final height = rect.height;
    final centerX = rect.center.dx;
    final centerY = rect.center.dy;
    final double radius = math.max(0, calculatedCornerRadius);
    final minSideLength = math.min(rect.width, rect.height);

    double leftX(double x) {
      return centerX + x * limitedRadius - width / 2;
    }

    double rightX(double x) {
      return centerX - x * limitedRadius + width / 2;
    }

    double topY(double y) {
      return centerY + y * limitedRadius - height / 2;
    }

    double bottomY(double y) {
      return centerY - y * limitedRadius + height / 2;
    }

    Path bezierRoundedRect() {
      return Path()
        ..moveTo(leftX(1.52866483), topY(0))
        ..lineTo(rightX(1.52866471), topY(0))
        ..cubicTo(
          rightX(1.08849323),
          topY(0),
          rightX(0.86840689),
          topY(0),
          rightX(0.66993427),
          topY(0.06549600),
        )
        ..lineTo(rightX(0.63149399), topY(0.07491100))
        ..cubicTo(
          rightX(0.37282392),
          topY(0.16905899),
          rightX(0.16906013),
          topY(0.37282401),
          rightX(0.07491176),
          topY(0.63149399),
        )
        ..cubicTo(
          rightX(0),
          topY(0.86840701),
          rightX(0),
          topY(1.08849299),
          rightX(0),
          topY(1.52866483),
        )
        ..lineTo(rightX(0), bottomY(1.52866471))
        ..cubicTo(
          rightX(0),
          bottomY(1.08849323),
          rightX(0),
          bottomY(0.86840689),
          rightX(0.06549600),
          bottomY(0.66993427),
        )
        ..lineTo(rightX(0.07491100), bottomY(0.63149399))
        ..cubicTo(
          rightX(0.16905899),
          bottomY(0.37282392),
          rightX(0.37282401),
          bottomY(0.16906013),
          rightX(0.63149399),
          bottomY(0.07491176),
        )
        ..cubicTo(
          rightX(0.86840701),
          bottomY(0),
          rightX(1.08849299),
          bottomY(0),
          rightX(1.52866483),
          bottomY(0),
        )
        ..lineTo(leftX(1.52866483), bottomY(0))
        ..cubicTo(
          leftX(1.08849323),
          bottomY(0),
          leftX(0.86840689),
          bottomY(0),
          leftX(0.66993427),
          bottomY(0.06549600),
        )
        ..lineTo(leftX(0.63149399), bottomY(0.07491100))
        ..cubicTo(
          leftX(0.37282392),
          bottomY(0.16905899),
          leftX(0.16906013),
          bottomY(0.37282401),
          leftX(0.07491176),
          bottomY(0.63149399),
        )
        ..cubicTo(
          leftX(0),
          bottomY(0.86840701),
          leftX(0),
          bottomY(1.08849299),
          leftX(0),
          bottomY(1.52866483),
        )
        ..lineTo(leftX(0), topY(1.52866471))
        ..cubicTo(
          leftX(0),
          topY(1.08849323),
          leftX(0),
          topY(0.86840689),
          leftX(0.06549600),
          topY(0.66993427),
        )
        ..lineTo(leftX(0.07491100), topY(0.63149399))
        ..cubicTo(
          leftX(0.16905899),
          topY(0.37282392),
          leftX(0.37282401),
          topY(0.16906013),
          leftX(0.63149399),
          topY(0.07491176),
        )
        ..cubicTo(
          leftX(0.86840701),
          topY(0),
          leftX(1.08849299),
          topY(0),
          leftX(1.52866483),
          topY(0),
        )
        ..close();
    }

    const totalAffectedCornerPixelRatio = 1.52865;
    const minimalUnclippedSideToCornerRadiusRatio =
        2.0 * totalAffectedCornerPixelRatio;
    const minimalEdgeLengthSideToCornerRadiusRatio = 2;
    const minRadiusEdgeLength = 200;

    final multiplier = ui.lerpDouble(
      minimalEdgeLengthSideToCornerRadiusRatio,
      minimalUnclippedSideToCornerRadiusRatio,
      minSideLength / minRadiusEdgeLength,
    )!;
    limitedRadius = math.min(radius, minSideLength / multiplier);

    return bezierRoundedRect();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return path(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return path(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (borderColor != null && borderWidth > 0) {
      final paint = Paint()
        ..color = borderColor!
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path(rect), paint);
    }
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) {
    return SquircleShapeBorder(
      cornerRadius: cornerRadius * t,
      borderWidth: borderWidth * t,
      borderColor: borderColor,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SquircleShapeBorder) {
      return SquircleShapeBorder(
        cornerRadius: ui.lerpDouble(a.cornerRadius, cornerRadius, t)!,
        borderWidth: ui.lerpDouble(a.borderWidth, borderWidth, t)!,
        borderColor: Color.lerp(a.borderColor, borderColor, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SquircleShapeBorder) {
      return SquircleShapeBorder(
        cornerRadius: ui.lerpDouble(cornerRadius, b.cornerRadius, t)!,
        borderWidth: ui.lerpDouble(borderWidth, b.borderWidth, t)!,
        borderColor: Color.lerp(borderColor, b.borderColor, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(Object other) {
    if (other is! SquircleShapeBorder) return false;
    return cornerRadius == other.cornerRadius &&
        borderWidth == other.borderWidth &&
        borderColor == other.borderColor;
  }

  @override
  int get hashCode => Object.hash(cornerRadius, borderWidth, borderColor);

  @override
  String toString() {
    return 'SquircleShapeBorder(cornerRadius: $cornerRadius, borderWidth: $borderWidth, borderColor: $borderColor)';
  }
}
