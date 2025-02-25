import 'package:app/feature/browserV2/screens/browser_view/widgets/background_blur.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/control_panel/browser_control_panel_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/button/button.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserControlPanel
    extends ElementaryWidget<BrowserControlPanelWidgetModel> {
  const BrowserControlPanel({
    Key? key,
    WidgetModelFactory<BrowserControlPanelWidgetModel> wmFactory =
        defaultBrowserControlPanelWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BrowserControlPanelWidgetModel wm) {
    return BackgroundBlur(
      child: SizedBox(
        height: DimensSizeV2.d48,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d24,
          ),
          child: Row(
            children: [
              Expanded(
                child: _IconButton(
                  svg: Assets.images.navigateBack.path,
                  onPressed: wm.onPressedBackPressed,
                ),
              ),
              Expanded(
                child: _IconButton(
                  svg: Assets.images.navigateForward.path,
                  onPressed: wm.onPressedForwardPressed,
                ),
              ),
              Expanded(
                child: _IconButton(
                  svg: Assets.images.verticalDots.path,
                  onPressed: wm.onPressedDotsPressed,
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
                  svg: Assets.images.layers.path,
                  onPressed: wm.onPressedTabs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO(Odrin): we should add all the icons in the ui kit library
class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.svg,
    required this.onPressed,
  });

  final String svg;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Center(
        child: SvgPicture.asset(
          svg,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
