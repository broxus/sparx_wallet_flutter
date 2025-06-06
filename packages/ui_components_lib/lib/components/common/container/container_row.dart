import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ContainerRow extends Container {
  ContainerRow({
    required List<Widget> children,
    super.key,
    super.alignment,
    super.padding = const EdgeInsets.all(DimensSize.d8),
    double? spacing = DimensSize.d8,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    Widget? separator,
    super.color,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.clipBehavior = Clip.none,
  }) : super(
          child: SeparatedRow(
            spacing: spacing,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            separator: separator,
            children: children,
          ),
        );
}
