import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.only(
      top: DimensSize.d12,
      bottom: DimensSize.d12,
      left: DimensSize.d12,
      right: DimensSize.d12,
    ),
    this.borderRadius,
    this.color,
  });

  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.colors.background1,
          borderRadius: borderRadius,
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
