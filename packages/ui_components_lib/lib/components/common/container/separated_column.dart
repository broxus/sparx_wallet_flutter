import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/components/common/container/separated_mixin.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
          spacing: separator != null ? 0 : (spacing ?? DimensSizeV2.d8),
          children: separator != null
              ? SeparatedMixin.buildChildren(
                  separator,
                  children,
                )
              : children,
        );
}
