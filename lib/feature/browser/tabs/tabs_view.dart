import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/tabs/tab_view.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// TODO(nesquikm): We should calculate this value based on the screen size
const _cardAspectRatio = 0.8;

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  late final _browserService = inject<BrowserService>();

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<BrowserTabsData>(
      listenableState: _browserService.tM.tabsState,
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
                    TabView(
                      tab: tab,
                      key: ValueKey(tab.id),
                      onPressed: () => _onChangeTab(tab.id),
                      onClosePressed: () =>
                          _onCloseTab(tab.id, data.count == 1),
                    ),
                ],
              ),
            ),
            const BrowserBottomMenuTabs(),
          ],
        );
      },
    );
  }

  void _onChangeTab(String id) {
    _browserService.tM.setActiveTab(id);
    // TODO(knightforce): need?
    context.goNamed(AppRoute.browser.name);
  }

  void _onCloseTab(String id, bool wasLast) {
    _browserService.tM.removeBrowserTab(id);
    if (wasLast) {
      // TODO(knightforce): need?
      context.goNamed(AppRoute.browser.name);
    }
  }
}
