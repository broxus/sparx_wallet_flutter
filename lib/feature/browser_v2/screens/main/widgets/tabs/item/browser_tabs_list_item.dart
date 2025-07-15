import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/widgets/browser_tabs_list_item_body.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabsListItem
    extends ElementaryWidget<BrowserTabsListItemWidgetModel> {
  BrowserTabsListItem({
    required NotNullListenableState<BrowserTab> tabNotifier,
    required this.renderManager,
    required this.onPressedTabMenu,
    this.onPressed,
    this.onClosePressed,
    super.key,
    WidgetModelFactory<BrowserTabsListItemWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultBrowserTabsListItemWidgetModelFactory(
                    ctx,
                    tabNotifier: tabNotifier,
                  ),
        );

  final RenderManager<String> renderManager;
  final VoidCallback onPressedTabMenu;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;

  @override
  Widget build(BrowserTabsListItemWidgetModel wm) {
    return SizedBox(
      height: DimensSizeV2.d200,
      child: RenderMetricsObject(
        id: wm.id,
        manager: renderManager,
        child: Stack(
          children: [
            BrowserTabsListItemBody(
              activeState: wm.activeState,
              tabNotifier: wm.tabNotifier,
              screenShotState: wm.screenShotState,
              onPressed: onPressed,
              onClosePressed: onClosePressed,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: _Menu(
                onPressed: onPressedTabMenu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
            color: ColorsResV2.midnightBlue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(DimensSizeV2.d4),
            child: Center(
              child: Icon(
                LucideIcons.ellipsis,
                color: colors.primaryA,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
