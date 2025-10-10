import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_divider}
///
/// Default divider of application, that is used to separate items in any list.
///
/// {@endtemplate}
class CommonDivider extends StatelessWidget {
  /// {@macro common_divider}
  const CommonDivider({super.key, this.color, this.margin = EdgeInsets.zero});

  static const size = 1.0;

  final Color? color;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Divider(
        height: CommonDivider.size,
        thickness: CommonDivider.size,
        color: color ?? context.themeStyleV2.colors.borderAlpha,
      ),
    );
  }
}

/// Default divider of application, that is used to separate items and header
/// sections in sliver lists.
class CommonSliverDividerHeaderDelegate extends SliverPersistentHeaderDelegate {
  CommonSliverDividerHeaderDelegate({this.color});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return CommonDivider(color: color);
  }

  final Color? color;

  @override
  double get maxExtent => CommonDivider.size;

  @override
  double get minExtent => CommonDivider.size;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
