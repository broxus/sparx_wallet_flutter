import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/extensions/extensions.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class Toolbar extends ElementaryWidget<ToolbarWidgetModel> {
  const Toolbar({
    required this.onPressedTabs,
    super.key,
    WidgetModelFactory<ToolbarWidgetModel> wmFactory =
        defaultToolbarWidgetModelFactory,
  }) : super(wmFactory);

  static const height = DimensSizeV2.d48;

  final VoidCallback onPressedTabs;

  @override
  Widget build(ToolbarWidgetModel wm) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: StateNotifierBuilder(
              listenableState: wm.backState,
              builder: (_, bool? isActive) => _IconButton(
                svg: Assets.images.navigateBack.path,
                onPressed: wm.onPressedBackPressed,
                isActive: isActive ?? true,
              ),
            ),
          ),
          Expanded(
            child: StateNotifierBuilder(
              listenableState: wm.forwardState,
              builder: (_, bool? isActive) => _IconButton(
                svg: Assets.images.navigateForward.path,
                onPressed: wm.onPressedForwardPressed,
                isActive: isActive ?? true,
              ),
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.layers.path,
              onPressed: onPressedTabs,
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.bookOpen.path,
              onPressed: wm.onPressedBook,
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.horizontalDots.path,
              onPressed: wm.onPressedDotsPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.svg,
    required this.onPressed,
    this.isActive = true,
  });

  final String svg;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isActive ? onPressed : null,
      child: Center(
        child: SvgPicture.asset(
          svg,
          width: 20,
          height: 20,
          colorFilter:
              (isActive ? colors.content3 : colors.content3.withAlpha(125))
                  .colorFilter,
          //isActive
        ),
      ),
    );
  }
}
