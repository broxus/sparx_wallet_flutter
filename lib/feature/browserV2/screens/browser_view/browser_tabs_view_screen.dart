import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/browser_view/browser_tabs_view_screen_wm.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/browser_web_tab/browser_web_tab.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/control_panel/browser_control_panel.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class BrowserTabsViewScreen extends ElementaryWidget<BrowserTabsViewScreenWidgetModel> {
  const BrowserTabsViewScreen({
    Key? key,
    WidgetModelFactory<BrowserTabsViewScreenWidgetModel> wmFactory =
        defaultBrowserTabsViewScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BrowserTabsViewScreenWidgetModel wm) {
    return Stack(
      children: [
        StateNotifierBuilder<BrowserTabsData?>(
          listenableState: wm.tabsState,
          builder: (_, BrowserTabsData? data) {
            if (data == null) {
              return const SizedBox.shrink();
            }
            return PageView.builder(
              itemCount: data.count,
              itemBuilder: (_, int index) {
                return BrowserWebTab(
                  key: ValueKey(data.tabs[index].id),
                  tab: data.tabs[index],
                );
              },
            );
          },
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BrowserControlPanel(),
        ),
      ],
    );
  }
}
