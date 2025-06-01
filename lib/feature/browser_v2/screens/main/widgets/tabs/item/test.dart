import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class ReactiveShapeWidget extends SingleChildRenderObjectWidget {
  const ReactiveShapeWidget({
    required this.activeState,
    required this.backgroundColor,
    required this.radius,
    required this.activeBorderWidth,
    required this.inactiveBorderWidth,
    required this.activeColor,
    required this.inactiveColor,
    required Widget child,
    super.key,
  }) : super(child: child);

  final ValueListenable<bool> activeState;
  final Color backgroundColor;
  final double radius;
  final double activeBorderWidth;
  final double inactiveBorderWidth;
  final Color activeColor;
  final Color inactiveColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ReactiveShapeRenderBox(
      activeState,
      backgroundColor,
      radius,
      activeBorderWidth,
      inactiveBorderWidth,
      activeColor,
      inactiveColor,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant ReactiveShapeRenderBox renderObject,
  ) {
    renderObject
      ..backgroundColor = backgroundColor
      ..radius = radius
      ..activeBorderWidth = activeBorderWidth
      ..inactiveBorderWidth = inactiveBorderWidth
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor;
  }
}

class ReactiveShapeRenderBox extends RenderProxyBox {
  ReactiveShapeRenderBox(
    this.activeState,
    this.backgroundColor,
    this.radius,
    this.activeBorderWidth,
    this.inactiveBorderWidth,
    this.activeColor,
    this.inactiveColor,
  ) {
    activeState.addListener(_onChanged);
  }

  final ValueListenable<bool> activeState;
  Color backgroundColor;
  double radius;
  double activeBorderWidth;
  double inactiveBorderWidth;
  Color activeColor;
  Color inactiveColor;

  void _onChanged() {
    markNeedsPaint();
  }

  @override
  void detach() {
    activeState.removeListener(_onChanged);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderWidth =
        activeState.value ? activeBorderWidth : inactiveBorderWidth;
    final borderPaint = Paint()
      ..color = activeState.value ? activeColor : inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final rRect = RRect.fromRectAndRadius(
      offset & size,
      Radius.circular(radius),
    );

    canvas
      ..drawRRect(rRect, fillPaint)
      ..drawRRect(rRect.deflate(borderWidth / 2), borderPaint);

    super.paint(context, offset);
  }
}
