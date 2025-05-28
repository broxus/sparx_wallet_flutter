import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/container/shaped_container_column.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PrimaryShapedContainerColumn extends StatelessWidget {
  const PrimaryShapedContainerColumn({
    required this.children,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    super.key,
  });

  final List<Widget> children;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ShapedContainerColumn(
      color: backgroundColor ?? context.themeStyleV2.colors.background2,
      separatorSize: .5,
      margin: margin,
      padding: padding,
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

class PrimaryShapedContainerItem extends StatelessWidget {
  const PrimaryShapedContainerItem({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    super.key,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.themeStyleV2.textStyles.labelMedium,
            ),
            Icon(
              icon,
              color: iconColor,
              size: DimensSizeV2.d16,
            ),
          ],
        ),
      ),
    );
  }
}
