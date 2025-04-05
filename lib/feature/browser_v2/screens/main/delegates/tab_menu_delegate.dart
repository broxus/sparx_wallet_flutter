import 'dart:async';

import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browser_v2/models/tab/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_menu/data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_menu/tab_menu.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:flutter/cupertino.dart';

class BrowserTabMenuDelegate {
  BrowserTabMenuDelegate({
    required this.renderManager,
    required this.onShowMenu,
    required this.onHideMenu,
    required this.addUrlToBookmark,
  });

  final BrowserRenderManager renderManager;
  final VoidCallback onShowMenu;
  final VoidCallback onHideMenu;
  final ValueChanged<String> addUrlToBookmark;

  Future<void> showTabMenu(
    BuildContext context,
    BrowserTab tab,
  ) async {
    final data = renderManager.getRenderData(tab.id);

    if (data == null) {
      return null;
    }

    onShowMenu();
    primaryBus.fire(HideNavigationEvent());

    final result = await showBrowserTabMenu(context, data);

    onHideMenu();
    primaryBus.fire(RevertNavigationEvent());

    switch (result) {
      case BrowserTabMenuItemData.copyLink:
        unawaited(
          setClipBoardData(
            tab.url.toString(),
          ),
        );
      case BrowserTabMenuItemData.pinTab:
      // TODO(knightforce): handle
      case BrowserTabMenuItemData.bookmark:
        addUrlToBookmark(tab.id);
      case BrowserTabMenuItemData.newTabGroup:
      // TODO(knightforce): handle
      case null:
    }
  }
}
