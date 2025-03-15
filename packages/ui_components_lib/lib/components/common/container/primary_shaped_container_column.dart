import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/container/shaped_container_column.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PrimaryShapedContainerColumn extends StatelessWidget {
  const PrimaryShapedContainerColumn({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ShapedContainerColumn(
      color: context.themeStyleV2.colors.background2,
      separatorSize: .5,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      separator: const SizedBox(
        width: double.infinity,
        height: .5,
        child: ColoredBox(
          // TODO(knightforce): move to colors
          color: Color.fromRGBO(128, 128, 128, 0.55),
        ),
      ),
      children: children,
    );
  }
}
