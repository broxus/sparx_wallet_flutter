import 'package:app/feature/browserV2/screens/tabs/browser_tabs_screen_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class BrowserTabsScreen extends ElementaryWidget<BrowserTabsScreenWidgetModel> {
  const BrowserTabsScreen({
    Key? key,
    WidgetModelFactory<BrowserTabsScreenWidgetModel> wmFactory =
        defaultBrowserTabsScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BrowserTabsScreenWidgetModel wm) {
    return const Placeholder();
  }
}
