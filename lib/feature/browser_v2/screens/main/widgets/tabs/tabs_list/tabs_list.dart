import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/tabs_list_action_bar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabsList extends ElementaryWidget<BrowserTabsListWidgetModel> {
  BrowserTabsList({
    // required ListenableState<List<BrowserTab>?> selectedTabsState,
    required ListenableState<String?> selectedGroupIdState,
    required RenderManager<String> renderManager,
    required ValueChanged<BrowserTab> onPressedTabMenu,
    required ValueChanged<String> onPressedGroup,
    required ValueChanged<String> onPressedTab,
    // required ValueChanged<String> onCloseTab,
    required VoidCallback onPressedCreateNewGroup,
    super.key,
    WidgetModelFactory<BrowserTabsListWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultBrowserTabsListWidgetModelFactory(
                    ctx,
                    // selectedTabsState: selectedTabsState,
                    selectedGroupIdState: selectedGroupIdState,
                    renderManager: renderManager,
                    onPressedTabMenu: onPressedTabMenu,
                    onPressedGroup: onPressedGroup,
                    onPressedTab: onPressedTab,
                    // onCloseTab: onCloseTab,
                    onPressedCreateNewGroup: onPressedCreateNewGroup,
                    // onPressedGroup: onPressedGroup,
                  ),
        );

  // TODO(nesquikm): We should calculate this value based on the screen size
  static const _cardAspectRatio = 0.9;

  static const _padding = EdgeInsets.only(
    top: DimensSizeV2.d24,
    bottom: DimensSizeV2.d16 + BrowserTabsListActionBar.height,
    left: DimensSizeV2.d16,
    right: DimensSizeV2.d16,
  );

  @override
  Widget build(BrowserTabsListWidgetModel wm) {
    return Column(
      children: [
        Flexible(
          child: TabListHeader(
            getPhysic: wm.getPhysic,
            onPressedCreateNewGroup: wm.onPressedCreateNewGroup,
            onPressedGroup: wm.onPressedGroup,
            onPressedBookmarks: wm.onPressedBookmarks,
            uiState: wm.uiState,
          ),
        ),
        const _Separator(),
        Expanded(
          child: StateNotifierBuilder<List<BrowserTab>?>(
            listenableState: wm.selectedGroupTabsState,
            builder: (_, List<BrowserTab>? tabs) {
              if (tabs == null) {
                return const SizedBox.shrink();
              }

              return GridView.count(
                // ignore: no-magic-number
                padding: _padding,
                crossAxisCount: 2,
                crossAxisSpacing: DimensSizeV2.d8,
                mainAxisSpacing: DimensSizeV2.d8,
                childAspectRatio: _cardAspectRatio,
                children: [
                  for (final tab in tabs)
                    BrowserTabsListItem(
                      key: ValueKey(tab.id),
                      renderManager: wm.renderManager,
                      tab: tab,
                      onPressedTabMenu: () => wm.onPressedTabMenu(tab),
                      onPressed: () => wm.onPressedTab(tab.id),
                      onClosePressed: () => wm.onCloseTab(tab.id),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: DimensSizeV2.d1,
      color: context.themeStyleV2.colors.primaryA.withAlpha(25),
    );
  }
}
