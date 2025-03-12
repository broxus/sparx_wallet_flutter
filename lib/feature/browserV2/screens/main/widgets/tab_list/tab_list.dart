import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/page_control_panel/page_control_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/tabs_list_control_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/header/tab_list_header.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/item/browser_tabs_list_item.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabsList extends StatelessWidget {
  const BrowserTabsList({
    required this.tabsState,
    required this.renderManager,
    required this.onPressedTabMenu,
    required this.onChangeTab,
    required this.onCloseTab,
    super.key,
  });

  final ListenableState<BrowserTabsCollection> tabsState;
  final RenderManager<String> renderManager;
  final ValueChanged<String> onPressedTabMenu;
  final ValueChanged<String> onChangeTab;
  final ValueChanged<String> onCloseTab;

  // TODO(nesquikm): We should calculate this value based on the screen size
  static const _cardAspectRatio = 0.9;

  static const _padding = EdgeInsets.only(
    top: DimensSizeV2.d24,
    bottom: DimensSizeV2.d16 + BrowserTabsListControlPanel.height,
    left: DimensSizeV2.d16,
    right: DimensSizeV2.d16,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TabListHeader(),
        const _Separator(),
        Expanded(
          child: StateNotifierBuilder(
            listenableState: tabsState,
            builder: (_, BrowserTabsCollection? tabs) {
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
                  for (final tab in tabs.list)
                    BrowserTabsListItem(
                      key: ValueKey(tab.id),
                      renderManager: renderManager,
                      tab: tab,
                      onPressedTabMenu: () => onPressedTabMenu(tab.id),
                      onPressed: () => onChangeTab(tab.id),
                      onClosePressed: () => onCloseTab(tab.id),
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
