import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

typedef IsColapsed = bool Function(SliverConstraints);

class DefaultSliverAppBar extends StatelessWidget {
  const DefaultSliverAppBar({
    required this.title,
    this.isCollapsed = defaultIsCollapsed,
    this.flexibleSpace,
    super.key,
  });

  final IsColapsed isCollapsed;
  final String title;
  final Widget? flexibleSpace;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        // Calculate if we're in collapsed state
        final isCollapsed = this.isCollapsed(constraints);

        return SliverAppBar(
          expandedHeight: 320,
          collapsedHeight: defaultAppBarHeight,
          toolbarHeight: defaultAppBarHeight,
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: isCollapsed
              ? theme.colors.background0
              : Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: Container(
            margin: const EdgeInsets.only(
              left: DimensSizeV2.d16,
              top: DimensSizeV2.d12,
              bottom: DimensSizeV2.d12,
            ),
            child: AppBarBackButton(
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          leadingWidth: DimensSizeV2.d64,
          title: AnimatedOpacity(
            opacity: isCollapsed ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Text(title, style: theme.textStyles.headingMedium),
          ),
          centerTitle: true,
          flexibleSpace: flexibleSpace,
        );
      },
    );
  }

  static bool defaultIsCollapsed(SliverConstraints constraints) {
    return constraints.scrollOffset > 200;
  }
}
