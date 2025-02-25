import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_list_wm.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/menu/browser_tabs_menu.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/tab.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// TODO(nesquikm): We should calculate this value based on the screen size
const _cardAspectRatio = 0.8;

class BrowserTabsList extends ElementaryWidget<BrowserTabsListWidgetModel> {
  const BrowserTabsList({
    Key? key,
    WidgetModelFactory<BrowserTabsListWidgetModel> wmFactory =
        defaultBrowserTabsListWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BrowserTabsListWidgetModel wm) {
    return StateNotifierBuilder<BrowserTabsData>(
      listenableState: wm.tabsState,
      builder: (_, BrowserTabsData? data) {
        if (data == null) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            Expanded(
              child: GridView.count(
                // ignore: no-magic-number
                padding: const EdgeInsets.only(
                  top: DimensSizeV2.d24,
                  bottom: DimensSizeV2.d16,
                  left: DimensSizeV2.d16,
                  right: DimensSizeV2.d16,
                ),
                crossAxisCount: 2,
                crossAxisSpacing: DimensSizeV2.d8,
                mainAxisSpacing: DimensSizeV2.d12,
                childAspectRatio: _cardAspectRatio,
                children: [
                  for (final tab in data.sortedTabs)
                    BrowserTabItemView(
                      tab: tab,
                      key: ValueKey(tab.id),
                      onPressed: () => wm.onChangeTab(tab.id),
                      onClosePressed: () =>
                          wm.onCloseTab(tab.id, data.count == 1),
                    ),
                ],
              ),
            ),
            const BrowserTabsMenu(),
          ],
        );
      },
    );
  }
}
