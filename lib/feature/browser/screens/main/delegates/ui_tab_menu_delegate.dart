import 'dart:async';

import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser/screens/main/widgets/tab_menu/data.dart';
import 'package:app/feature/browser/screens/main/widgets/tab_menu/tab_menu.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';

// ignore: one_member_abstracts
abstract interface class BrowserTabMenuUi {
  Future<void> showTabMenu(BrowserTab tab);
}

class BrowserTabMenuUiDelegate implements BrowserTabMenuUi {
  BrowserTabMenuUiDelegate(
    this.model,
    this.context, {
    required this.tabsRenderManager,
    required this.createGroup,
  });

  final BrowserMainScreenModel model;
  final BuildContext context;
  final BrowserTabsRenderManager tabsRenderManager;
  final ValueChanged<String> createGroup;

  final _duration =
      CustomBottomNavigationBar.animateDuration +
      const Duration(milliseconds: 50);

  @override
  Future<void> showTabMenu(BrowserTab tab) async {
    final result = await Future.delayed(_duration, () {
      final data = tabsRenderManager.getRenderData(tab.id);
      if (data != null && context.mounted) {
        return showBrowserTabMenu(context, data);
      }
    });

    switch (result) {
      case BrowserTabMenuItemData.copyLink:
        unawaited(setClipBoardData(tab.url.toString()));
      case BrowserTabMenuItemData.pinTab:
      // TODO(knightforce): handle
      case BrowserTabMenuItemData.bookmark:
        model.addUrlToBookmark(tab.id);
      case BrowserTabMenuItemData.newTabGroup:
        createGroup(tab.id);
      case null:
    }
  }
}
