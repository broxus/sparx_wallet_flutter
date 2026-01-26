import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/components/common/container/separated_mixin.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SeparatedColumn extends Column with SeparatedMixin {
  SeparatedColumn({
    required List<Widget> children,
    Widget? separator,
    double? spacing,
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
  }) : super(
         spacing: separator != null ? 0 : (spacing ?? DimensSize.d8),
         children: separator != null
             ? SeparatedMixin.buildChildren(separator, children)
             : children,
       );
}
